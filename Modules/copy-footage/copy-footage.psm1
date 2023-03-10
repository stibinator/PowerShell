function Copy-Footage {
  param (
    [string] $MVNumber = -1,
    # [string] $findFolder,
    [datetime]$newerThan,
    [int]$DayAdjust,
    [int]$HourAdjust,
    [int]$MinAdjust,
    [string] $folderName = "",
    [string] $description = "",
    [string] $footageDrive = "v:",
    [string] $subFolder = "",
    [switch] $overwriteDupes,
    [string] $wildcard = "",
    [switch] $DontMakeSubFolders,
    [switch] $MoviesOnly,
    [switch] $AudioOnly,
    [switch] $ImagesOnly,
    [switch] $IncludeNonAVFileTypes,
    [switch] $makeDestDir,
    [switch] $dontUpdateDB,
    [switch] $dontUpdateFolderList,
    [switch] $dontUseFootageFolder,
    [switch] $UseFullTimeStamp
  )

  
  $AVExtensions = "\.(mp[0-9]+)|(mov)|(avi)|(webm)|(mkv)|(wav)|(aiff*)|(aac)|(ac3)|(jpe*g)|(cr2)|(arw)|(raw)|(braw)"
  $PicExtensions = "\.(jpe*g)|(cr2)|(arw)|(raw)"
  $MovieExtensions = "\.(mp4+)|(mov)|(avi)|(mkv)|(webm)|(braw)"
  $AudioExtensions = "\.(mp3)|(aac)|(ac3)|(wav)|(aif*)"
 
  # --------------------------------------------------------------------------------------------- 
  function fileContentsMatch {
    param(
      [parameter(Mandatory)]$fileA,
      [parameter(Mandatory)]$fileB,
      $searchlength = 2048 #how deep into the file we want to compare 
      # (reading from the tail) 
      # Not a statistician, but the chances of two different video files 
      # matching further than this has to be vanishingly small
      # reading in 2kb is waaay faster than calculating hashes of video files BTW.
    )
    try {
      if ($fileA.getType().name -eq "String") {
        $fileA = get-item $fileA
      }
      if ($fileB.getType().name -eq "String") {
        $fileB = get-item $fileB
      }
    }
    catch {
      write-host ("At least two files are needed to compare. Inputs must be paths to files or fileInfo objects")
      return
    }
    # this will catch almost all non-matching files
    if ($fileA.length -ne $fileB.length) {
      return $false
    }
    else {
      $ln = (($fileA.length, $fileB.length, $searchlength) | Measure-Object -minimum).minimum
      # write-host $fileA.length $fileB.length $ln
      $abytes = Get-Content $fileA -AsByteStream -tail $ln #-TotalCount $ln
      $bbytes = Get-Content $fileB -AsByteStream -tail $ln #-TotalCount $ln
      $i = 0 # $headerLength
      while (($i -lt $ln) -and ($abytes[$i] -eq $bbytes[$i])) { $i++ }
      # Write-Host $i
      return $i -eq $searchlength
    }
  }
  # --------------------------------------------------------------------------------------------- 
  function get-DupeFile {
    param (
      $destFolder,
      $item
    )
    if (test-path $destFolder) {
      $existingFiles = Get-ChildItem $destFolder
      for ( $i = 0; $i -lt $existingFiles.Length; $i++ ) {
        # Write-Host "last writeTime matches: " ($existingFiles[$i].LastWriteTime -eq $item.LastWriteTime) -ForegroundColor Yellow
        # Write-Host "fileContent matches" (fileContentsMatch $existingFiles[$i] $item)
        if (
        ( $existingFiles[$i].LastWriteTime -eq $item.LastWriteTime ) -and
        (fileContentsMatch $existingFiles[$i] $item) 
        ) {
          return $existingFiles[$i]
        }
      }
      return $false 
    }
  }
  
  # --------------------------------------------------------------------------------------------- 
  function createOuterFolder {
    param(
      $footageDrive,
      $MVNumber,
      $createDir,
      $folderName
    )
    $outerFolder = Get-ChildItem ("$footageDrive\MV{0:d5}*" -f $MVNumber)
    if ((! ($outerFolder.Exists)) -or $null -eq $outerFolder) {
      if ($createDir) {
        if ($folderName -eq "") {
          $foldername = Read-Host "Name for destination folder"
        }
        $newFolder = "$footageDrive\MV{0:d5}{1}" -f $MVNumber, $(if ($folderName -ne "") { "-" + $folderName })
        Write-Host ("destination folder will be created at`n{0}" -f $newFolder) -ForegroundColor DarkYellow
        $outerFolder = $newFolder
        $createDir = $true
      }
      else {
        throw "destination folder not found. Use -makeDestDir to automatically create one"
        $createDir = $false
      }
    }
    else {
      Write-Host ("destination folder`n{0}" -f $outerFolder) -ForegroundColor Green
      $createDir = $false
    } 
    return @{
      outerFolder = $outerFolder
      createDir   = $createDir
    }
  }
  # --------------------------------------------------------------------------------------------- 
  function CF_connectToDB () {
    $pwFile = join-path (Split-Path $script:MyInvocation.MyCommand.Path) "dbpw.bat"
    $dbPW = Get-Content ($pwFile ) | ConvertTo-SecureString
    Write-Host "connecting to db"
    $Credentials = New-Object System.Management.Automation.PSCredential "webuser", $dbPW
    $conn = Connect-MySqlServer -ComputerName "production.mv.vic.gov.au" -Credential $Credentials
    Select-MySqlDatabase 'tapedb' -Connection $conn
    $testCount = "SELECT MAX(tape_ID) FROM Tapedb"
    $testDB = (Invoke-MySQLQuery -Connection $conn -Query $testCount).table.table[0]
    write-host ("found {0} records in tape DB" -F $testDB)
    return $conn
  }

  # --------------------------------------------------------------------------------------------- 
  function db_needsNewEntry {
    param(
      $tape_ID_Number,
      $conn
    )
    $query = ("SELECT * FROM tapeDB WHERE Tape_ID = {0}" -f $tape_ID_Number)
    $entryExists = Invoke-MySqlQuery -Connection $conn -Query $query
    return $null -eq $entryExists
  }

  # --------------------------------------------------------------------------------------------- 
  function createDestFolder {
    param (
      $containingFolder,
      $noSubFolders,
      $subFol,
      $d
    )
    $destSubFolder = $containingFolder
    if (! ($noSubFolders)) {
      if ("" -eq $subFol) {
        $dateFolder = ("{0:d2}_{1:d2}\" -f $d.day, $d.Month)
      }
      else {
        $dateFolder = (Join-path $subFol ("{0:d2}_{1:d2}\" -f $d.day, $d.Month))
      }
      if ($dontUseFootageFolder) {
        $destSubFolder = Join-path $containingFolder $dateFolder 
      }
      else {
        $destSubFolder = Join-path $containingFolder "Footage" $dateFolder 
      }
    }
    return $destSubFolder
  }

  # --------------------------------------------------------------------------------------------- 
  function splitLRAudioFiles {
    param(
      $name
    )
    if ($name -match "(-[LR])01.wav") {
      return $Matches[1]
    }
    else {
      return ""
    }
  }
  
  # --------------------------------------------------------------------------------------------- 
  function getSerialLength {
    param ($file)
    $count = (Get-ChildItem $file.Directory | Measure-Object).count
    $zeroes = ([string]$count).length
    return $zeroes    
  }
  # --------------------------------------------------------------------------------------------- 
  function formatFullName {
    param(
      $serial,
      $digits,
      $number, 
      $d,
      $inFile,
      [switch]$UseFullTimeStamp
    )
    $LR = splitLRAudioFiles $inFile.Name
    if ($UseFullTimeStamp) {
      # for full-timestamped files the serial is empty if it is 0
      if ($serial) { 
        $serial = "_{0:d$digits}" -f $serial 
      }
      else {
        $serial = ""
      }
      $suffix = @($number, $d.day, $d.Month, $d.Year, $d.Hour, $d.Minute, $d.Second, $LR, $serial, $inFile.Extension)
      return "MV{0:d5}-{1:d2}_{2:d2}_{3:d2}-{4:d2}_{5:d2}_{6:d2}{7}{8}{9}" -f $suffix
    }
    else {
      $serial = "_{0:d$digits}" -f $serial
      $suffix = @($number, $d.day, $d.Month, $LR, $serial, $inFile.Extension)
      return "MV{0:d5}-{1:d2}_{2:d2}{3}{4}{5}" -f $suffix
    }
  }
  # --------------------------------------------------------------------------------------------- 
  function inFileList {
    param(
      $candidateFullName,
      $list
    )

    for ($f = 0; $f -lt $list.length; $f++) {
      if ($list[$f].Dest -eq $candidateFullName) { return $true }
    }
    return $false
  }
  # --------------------------------------------------------------------------------------------- 
  function createDestName {
    param(
      $inFile,
      $parentFolder,
      $number,
      $d,
      $FileList,
      [switch]$UseFullTimeStamp
    )

    $serial = 0
    $digits = 1 + (getSerialLength $infile)
    
    $name = formatFullName  $serial $digits $number $d $inFile $UseFullTimeStamp
    $fullname = join-path $parentFolder $name
    while ((Test-Path $fullname) -or (inFileList $fullname $FileList)) { 
      $serial++
      $name = formatFullName  $serial $digits $number $d $inFile $UseFullTimeStamp
      $fullname = join-path $parentFolder $name
    }
    return $fullname
  }
  # --------------------------------------------------------------------------------------------- 
  #                                          The Hoo-Hah                                            #
  # --------------------------------------------------------------------------------------------- #
  $conn = CF_connectToDB
  $checkDate = ($null -ne $newerThan)
  $minuteAdjustment = $(if ($null -eq $DayAdjust) { 0 } else { $DayAdjust * 24 * 60 })
  $minuteAdjustment += $(if ($null -eq $HourAdjust) { 0 } else { $HourAdjust * 60 })
  $minuteAdjustment += $(if ($null -eq $MinAdjust) { 0 } else { $MinAdjust })
  
  if ($folderName -ne "") { $makeDestDir = $true }
  
  # strip the "MV" part off the mv number
  if ($MVNumber -match "MV([0-9]+)") { $MVNumber = $Matches[1] }

  $destination = createOuterFolder $footageDrive $MVNumber $makeDestDir $folderName

  $firstShootTime = Get-Date
  $FileList = @()

  # --------------------------------------------------------------------------------------------- #
  #                                         MAIN LOOP                                           #
  # --------------------------------------------------------------------------------------------- #

  Get-ChildItem -File -R | Where-Object { (
      ((($IncludeNonAVFileTypes `
            -or (`
            (! ($MoviesOnly -or $AudioOnly)) -and $_.Extension -Match $AVExtensions)`
            -or ($MoviesOnly -and $_.Extension -Match $MovieExtensions)`
            -or ($AudioOnly -and $_.Extension -Match $AudioExtensions)`
            -or ($ImagesOnly -and $_.Extension -Match $PicExtensions)`
        )`
      ) -and ($_.name -match $wildcard)) -and `
      (($checkDate -and $_.LastWriteTime -gt $newerThan) -or (! $checkDate)))
  } | ForEach-Object {

    $fileDate = $_.LastWriteTime.AddMinutes($minuteAdjustment) 
    if ($fileDate -lt $firstShootTime) { $firstShootTime = $fileDate }

    $destFolder = createDestFolder $destination.outerFolder $DontMakeSubFolders $subFolder $fileDate

    $dupe = get-DupeFile $destFolder  $_
    if ($dupe -and $overwriteDupes) {
      $destName = $dupe
    } 
    
    Write-Host $_.Name -NoNewline
    if ($dupe) {
      if ($overwriteDupes) {
        Write-Host (" -->`nreplacing ") -NoNewline -ForegroundColor DarkRed -BackgroundColor Yellow
        Write-Host ($dupe) -ForegroundColor Yellow
        $FileList += @{FName = $_.FullName; DestFol = $destFolder; Dest = $destName }
      }
      else {
        Write-Host (" --|->`nnot replacing ") -NoNewline -ForegroundColor Cyan
        Write-Host ($dupe) -ForegroundColor Blue
      }
    }
    else {
      $destName = createDestName $_ $destFolder $MVNumber $fileDate $FileList, $FileList $UseFullTimeStamp
      Write-Host (" -->") -ForegroundColor Green
      Write-Host ($destName) -ForegroundColor Green
      $FileList += @{FName = $_.FullName; DestFol = $destFolder; Dest = $destName }
    }
  } 
  if ($FileList.length -gt 0) {
    Write-Host("Proceed?`ny/N ") -NoNewline
    $y = read-host
    if ($y -match "y.*") {
      if ($destination.createDir) {
        mkdir $destination.outerFolder
      }
      $i = 0
      $FileList | ForEach-Object {
        write-host ("{0} out of {1} processed" -f $i, $FileList.length)
        $i++
        if (! ($DontMakeSubFolders)) {
          if (!(Test-Path ($_.DestFol))) {
            mkdir ($_.DestFol)
          }
        }
        if ((! (Test-Path $_.Dest)) -or $overwriteDupes) {
          Copy-Item  $_.fname $_.Dest -v
        }
        else {
          Write-Host "File already exists: " -ForegroundColor DarkYellow -NoNewline
          Write-Host ("{0}" -f $_.Dest)
        }
      }
      write-host ("{0} out of {1} processed" -f $i, $FileList.length)
      
      if (! $dontUpdateDB) {
        # import-module -Name mysql -ErrorAction SilentlyContinue
        import-module -Name update-mvvdb -ErrorAction SilentlyContinue
        $shootDate = "{0}_{1}_{2}" -f $firstShootTime.Year, $firstShootTime.Month, $firstShootTime.Day
      
        if (db_needsNewEntry $MVNumber $conn) {
          while ($description -eq "") {
            $description = read-host "please enter a description"
          }
          $query = ("INSERT INTO tapeDB (title, description, shoot_date) VALUES ('{0}', '{1}', '{2}')" -f $folderName.replace("'", "''"), $description.replace("'", "''"), $shootDate)
          Write-Host ("Inserting MV{0:d5}`nTitle = {1}`nDescription = {2}`nShoot date = {3}" -f $MVNumber, $folderName, $description, $shootDate)
          $goahead = ((Read-Host "Ok to Proceed? (Y/n)").ToLower() -eq "y")
          if ($goahead) { 
            Invoke-MySQLQuery -Connection $conn -Query $query
          }
        }
        else {
          if ($folderName -eq "") {
            $folderName = (Invoke-MySQLQuery -Connection $conn -Query ("SELECT Title FROM tapedb WHERE tape_id = {0}" -f $MVNumber)).table.table[0]
          }
          if ($description -eq "") {
            $description = (Invoke-MySQLQuery -Connection $conn -Query ("SELECT description FROM tapedb WHERE tape_id = {0}" -f $MVNumber)).table.table[0]
          }
          Write-Host -ForegroundColor Blue "Current database listing:"
          Write-Host -ForegroundColor Blue "Title:"
          Write-Host $folderName -ForegroundColor Cyan
          Write-Host -ForegroundColor Blue "Description:"
          Write-Host $description -ForegroundColor Cyan
          $dontEdit = Read-Host "Hit E to edit or enter to keep"
          if ($dontEdit -ne "") {
            Write-Host "Title: "  -NoNewline -ForegroundColor Blue
            Write-Host $folderName -ForegroundColor Cyan 
            $newTitle = read-host ("Type new title or hit enter to keep" -f $folderName)
            if ($newTitle -ne "") { $folderName = $newTitle }
           
            Write-Host "description: "  -NoNewline -ForegroundColor Blue
            write-host $description -ForegroundColor Cyan 
            $newDesc = read-host ("Type new description or hit enter to keep" -f $description)
            if ($newDesc -ne "") { $description = $newDesc }

            $query = ("UPDATE tapeDB SET title = '{0}', description = '{1}' WHERE tape_id = {3}" -f $folderName.replace("'", "''"), $description.replace("'", "''"), $shootDate, $MVNumber)
            Write-Host "Updating: " -NoNewline -ForegroundColor Blue
            Write-Host ("MV{0:d5}" -f $MVNumber) -ForegroundColor Cyan
            Write-Host "Title: "  -NoNewline -ForegroundColor Blue
            Write-Host $folderName -ForegroundColor Cyan 
            Write-Host "description: "  -NoNewline -ForegroundColor Blue
            write-host $description -ForegroundColor Cyan 
            $goahead = ((Read-Host "Ok to Proceed? (Y/n)").ToLower() -eq "y")
            if ($goahead) { 
              Invoke-MySQLQuery -Connection $conn -Query $query 
            }
          }
        }
      }
      if (-not $dontUpdateFolderList) {
        update-mvvdb -MVVDBNumbers $MVNumber -dontWaitForResponse
      }
    }
  }
  else {
    Write-Host "found no files to copy in this directory, or any of its subdirectories"
  }
}

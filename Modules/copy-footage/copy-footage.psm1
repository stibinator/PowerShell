function CF_filesMatch {
  param(
    $fileA,
    $fileB,
    $searchlength = 2048
  )
  if ($fileA.length -ne $fileB.length) {
    return false
  }
  else {
    $ln = (($fileA.length, $fileB.length, $searchlength) | Measure-Object -minimum).minimum
    write-host $fileA.length $fileB.length
    $abytes = Get-Content $fileA -AsByteStream -TotalCount $ln
    $bbytes = Get-Content $fileB -AsByteStream -TotalCount $ln
    $i = 0
    while (($i -lt $ln) -and ($abytes[$i] -eq $bbytes[$i])) { $i++ }
    return $i -eq $searchlength
  }
}
function CF_dupeExists {
  param (
    $destFolder,
    $item
  )
  $existingFiles = Get-ChildItems $destFolder
  for ( $i = 0; $i -lt $existingFiles.Length; $i++ ) {
    if (
      ( $existingFiles[$i].LastWriteTime -eq $item.LastWriteTime ) -and
      (CF_filesMatch $existingFiles[$i] $item) 
    ) {
      return $existingFiles[$i]
    }
    return $false 
  }
}

function CF_connectToDB () {
  Write-Host "connecting to db"
  $dbPW = Get-Content (join-path (Split-Path $script:MyInvocation.MyCommand.Path) "dbpw.bat" ) | ConvertTo-SecureString
  $Credentials = New-Object System.Management.Automation.PSCredential "webuser", $dbPW
  $conn = Connect-MySqlServer -ComputerName "production.mv.vic.gov.au" -Credential $Credentials
  Select-MySqlDatabase 'tapedb' -Connection $conn
  return $conn
}

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
 
  $conn = CF_connectToDB

  if ($MVNumber -lt 0) { 
    $MVNumber = $(1 + (Invoke-MySQLQuery -Connection $conn -Query "SELECT MAX(tape_ID) FROM Tapedb").table.table[0])
    write-host "Will create  MV Number $MVNumber"
  }

  $checkDate = ($null -ne $newerThan)
  $minuteAdjustment = $(if ($null -eq $DayAdjust) { 0 } else { $DayAdjust * 24 * 60 })
  $minuteAdjustment += $(if ($null -eq $HourAdjust) { 0 } else { $HourAdjust * 60 })
  $minuteAdjustment += $(if ($null -eq $MinAdjust) { 0 } else { $MinAdjust })
    
  if ($folderName -ne "") { $makeDestDir = $true }

  if ($MVNumber -match "MV([0-9]+)") { $MVNumber = $Matches[1] }

  $outerFolder = Get-ChildItem ("$footageDrive\MV{0:d5}*" -f $MVNumber)
  if ((! ($outerFolder.Exists)) -or $null -eq $outerFolder) {
    if ($makeDestDir) {
      if ($folderName -eq "") {
        $foldername = Read-Host "Name for destination folder"
      }
      $newFolder = "$footageDrive\MV{0:d5}{1}" -f $MVNumber, $(if ($folderName -ne "") { "-" + $folderName })
      Write-Host ("destination folder will be created at`n{0}" -f $newFolder) -ForegroundColor DarkYellow
      $outerFolder = $newFolder
      $makeDestDir = $true
      $newEntry = $true
    }
    else {
      throw "destination folder not found. Use -makeDestDir to automatically create one"
      $makeDestDir = $false
    }
  }
  else {
    Write-Host ("destination folder`n{0}" -f $outerFolder) -ForegroundColor Green
    $makeDestDir = $false
    $newEntry = $false
  } 
  $firstShootTime = Get-Date
  $FileList = @()
  $SerialNum = 0
  $digits = ("" + (Get-ChildItem -File -R | Measure-Object).count).length # quick way to get how many digits we need for the serial


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
    $d = $_.LastWriteTime.AddMinutes($minuteAdjustment); 
    if ($d -lt $firstShootTime) { $firstShootTime = $d }
    $destFolder = $outerFolder
    if (! ($DontMakeSubFolders)) {
      if ("" -eq $subFolder) {
        $dateFolder = ("{0:d2}_{1:d2}\" -f $d.day, $d.Month)
      }
      else {
        $dateFolder = (Join-path $subFolder ("{0:d2}_{1:d2}\" -f $d.day, $d.Month))
      }
      if ($dontUseFootageFolder) {
        $destFolder = Join-path $outerFolder $dateFolder 
      }
      else {
        $destFolder = Join-path $outerFolder "Footage" $dateFolder 
      }
    }
    if ($_.Name -match "(-[LR])01.wav") {
      $LR = $Matches[1]
    }
    else {
      $LR = ""
    }
    $Serial = ("{0:d$digits}" -f $SerialNum)
    if ($_.Extension -Match $PicExtensions) {
      if ($_.name -match ("([0-9]+){0}" -f $_.Extension)) {
        $Serial = $Matches[1]
      }
      $destName = join-path $destFolder ("MV{0:d5}-{1}{2}" -f $MVNumber, $Serial, $_.Extension)  
    }
    else {
      if ($UseFullTimeStamp) {
        $destName = join-path $destFolder ("MV{0:d5}-{1:d2}_{2:d2}_{3:d2}-{4:d2}_{5:d2}_{6:d2}{7}{8}" -f $MVNumber, $d.day, $d.Month, $d.Year, $d.Hour, $d.Minute, $d.Second, $LR, $_.Extension)
      }
      else {
        $destName = join-path $destFolder ("MV{0:d5}-{1:d2}_{2:d2}-{3:d$digits}{4}{5}" -f $MVNumber, $d.day, $d.Month, "#serial#", $LR, $_.Extension)
      }
    }
    $SerialNum++
    Write-Host $_.Name -NoNewline
    $dupeExists = CF_dupeExists $destFolder  $_
    if (      ($UseFullTimeStamp -and (Test-Path $destName)) -or $dupeExists ) {
      if ($overwriteDupes) {
        Write-Host (" -->`nreplacing ") -NoNewline -ForegroundColor DarkRed -BackgroundColor Yellow
        Write-Host ($destName) -ForegroundColor Yellow
        $FileList += @{FName = $_.FullName; DestFol = $destFolder; Dest = $destName }
      }
      else {
        Write-Host (" -->`nnot replacing ") -NoNewline -ForegroundColor Cyan
        Write-Host ($destName) -ForegroundColor Blue
      }
    }
    else {
      Write-Host (" -->") -ForegroundColor Green
      Write-Host ($destName) -ForegroundColor Green
      $FileList += @{FName = $_.FullName; DestFol = $destFolder; Dest = $destName }
    }
  }
  Write-Host("Proceed?`ny/N ") -NoNewline
  $y = read-host
  if ($y -match "y.*") {
    if ($makeDestDir) {
      $outerFolder = mkdir $outerFolder
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
      import-module -Name mysql -ErrorAction SilentlyContinue
      import-module -Name update-mvvdb -ErrorAction SilentlyContinue
      $shootDate = "{0}_{1}_{2}" -f $firstShootTime.Year, $firstShootTime.Month, $firstShootTime.Day
      if ($newEntry) {
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
            Invoke-MySQLQuery -Connection $conn -Query $query; 
          }
        }
      }
    }
    if (-not $dontUpdateFolderList) {
      update-mvvdb -MVVDBNumbers $MVNumber -dontWaitForResponse
    }
  }
}
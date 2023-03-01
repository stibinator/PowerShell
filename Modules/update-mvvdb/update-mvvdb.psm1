function ParseDate([string]$date) {
    $result = 0
    if (!([DateTime]::TryParse($date, [ref]$result))) {
        throw "You entered an invalid date: $date"
    }
    
    $result
}

function getDir {
    param (
        [string]$text,
        [switch]$newFolderBtn
    )
    Add-Type -AssemblyName System.Windows.Forms
    $browser = New-Object System.Windows.Forms.FolderBrowserDialog
    $browser.Description = $text
    $browser.UseDescriptionForTitle = $true
    $browser.ShowNewFolderButton = $newFolderBtn
    $null = $browser.ShowDialog()
    return $browser.SelectedPath
}

function update-mvvdb {
    param(
        [string[]]$MVVDBNumbers,
        [dateTime]$newerThan,
        [dateTime]$olderThan,
        [string]$after,
        [string]$before,
        [switch]$force,
        [int]$maxRecursion = -1,
        [object]$exts = @(".264", ".3ds", ".3gp", ".7z", ".aac", ".aaf", 
            ".ac3", ".aep", ".afm", ".ai", ".aif", ".aiff", ".arw", ".ass",
            ".au", ".avi", ".bdd", ".bmp", ".cr2", ".css", ".csv", ".cube",
            ".dng", ".doc", ".docx", ".dspproj", ".dv", ".dwg", ".dxf", ".eps",
            ".fcp", ".fcpxml", ".flac", ".gif", ".htm", ".html", ".iff", ".jp2",
            ".jpeg", ".jpg", ".js", ".json", ".look", ".lst", ".lwo", ".lws",
            ".m2v", ".m4a", ".m4v", ".max", ".mkv", ".mot", ".motn", ".mov",
            ".mp3", ".mp4", ".mpeg", ".mpg", ".mt", ".mtl", ".mts", ".mxf",
            ".obj", ".odt", ".ogg", ".ogv", ".omf", ".otf", ".pct", ".pdf", ".pfx",
            ".pix", ".png", ".pptx", ".prj", ".prproj", ".psd", ".pst", ".qt",
            ".r3d", ".rar", ".rtf", ".sesx", ".srf", ".srt", ".stap", ".stmp",
            ".textclipping", ".tga", ".thm", ".tif", ".tiff", ".ttf", ".txt",
            ".vob", ".wav", ".webm", ".wma", ".wmv", ".xls", ".xlsx", ".zip"),
        [switch]$DontWaitForResponse,
        [switch]$ReviewEachQuery,
        [string]$mvvdbPath 
    )
    import-module get-sequentialAwareFileList
    import-module MySQL
    

    $password = ConvertTo-SecureString "Hwv2KjKbH5ZK8yPG" -AsPlainText -Force
    $Cred = New-Object System.Management.Automation.PSCredential ("webuser", $password)
    $Global:MySQLConnection = Connect-MySqlServer -ComputerName "production.mv.vic.gov.au" -Credential $cred 
    $prefs = @{}
    if (! (Test-Path  $mvvdbPath)) {
        $prefs = Import-Clixml (Join-Path $env:APPDATA "update-mvvdb.xml") -ErrorAction SilentlyContinue
        if (Test-Path $prefs.mvvdbPath -ErrorAction SilentlyContinue) {
            $mvvdbPath = $prefs.mvvdbPath
        }
        else {
            $mvvdbPath = getDir "Select the MVVDB media folder"
        }
        if (Test-Path  $mvvdbPath) {
            $prefs.mvvdbPath = $mvvdbPath
            Export-Clixml -path (Join-Path $env:APPDATA "update-mvvdb.xml") -InputObject $prefs
        }
        else {
            throw "MVVDB path not found"
        }
    }
    
    
    $folders = @()
    $result = $false
    if ($MVVDBNumbers.length ) {
        for ($i = 0; $i -lt $MVVDBNumbers.length; $i++) {
            if (test-path $MVVDBNumbers[$i]) {
                $folders += get-item $MVVDBNumbers[$i]
            }
            else {
                $folders += get-item (join-path $mvvdbPath ("MV{0:d5}*" -f $MVVDBNumbers[$i]));
            }
        }
        
    }
    
    if ($newerThan) {
        $oldestDate = parseDate($newerThan)
        $folders += Get-ChildItem $mvvdbPath -directory -R | where-object {
            ($_.LastWriteTime -gt $oldestDate -and ($_.name -match "MV([0-9]+)"))
        }
    }
    
    if ($olderThan) {
        $newestDate = parseDate($olderThan)
        $folders += Get-ChildItem $mvvdbPath -directory -R | where-object {
            ($_.LastWriteTime -lt $newestDate -and ($_.name -match "MV([0-9]+)"))
        }
    }
    
    if ($after) {
        $folders += Get-ChildItem $mvvdbPath -directory -R | where-object {
            $oldFolder = get-item (join-path $mvvdbPath ("MV{0:d5}*" -f ($after.replace("MV", ""))))
            ($_.LastWriteTime -gt $oldFolder.LastWriteTime -and ($_.name -match "MV([0-9]+)"))
        }
    }
    
    if ($before) {
        $folders += Get-ChildItem $mvvdbPath -directory -R | where-object {
            $newFolder = get-item (join-path $mvvdbPath ("MV{0:d5}*" -f ($before.replace("MV", ""))))
            ($_.LastWriteTime -lt $newFolder.LastWriteTime -and ($_.name -match "MV([0-9]+)"))
        }
    }
    
    if ($force) {
        Write-Host "listing the entire production drive" -ForegroundColor DarkGreen
        $folders += Get-ChildItem $mvvdbPath -directory | where-object {
            $_.name -match "MV([0-9]+)"
        }
    }
    
    Write-Host ("found {0} folders to index" -f $folders.length) -ForegroundColor  $(if ($folders.length -gt 0) { "green" } else { "red" })
    
    if (! $DontWaitForResponse) { 
        $response = (read-Host "Write to db? Y/n" );
        $go = $response.ToLower() -match "y"
    }
    else {
        $go = $true
    }
    if ($go) {
        if ($folders.length -gt 0) {
            for ($f = 0; $f -lt $folders.length; $f++) {
                if ($folders[$f].name -match "MV([0-9]+)") {
                    $MVVDBNumber = $Matches[1];
                    $fl = get-sequentialAwareFileList $folders[$f].fullname -includeFilesOfType $exts -outputFormat indentedText -verbose 1;
                    $query = ("UPDATE tapedb.tapedb SET folder_list='{0}' WHERE tape_id={1};" -f $fl.replace("'", "''"), $MVVDBNumber);
                    if ($ReviewEachQuery) { 
                        Write-Host $query -ForegroundColor Green; 
                        $go = (read-Host "Write to db? Y/n" );
                    }
                    if ((! $ReviewEachQuery) -or $go.ToLower() -match "y") {
                        $result = Invoke-MySqlQuery -Query $query;
                    }
                }
                else {
                    Write-Host ("Folder name {0} is not in the database" -f $folders[$f].name)
                }
            }
        }
        else {
            throw ("Folder {0} not found. Specify at least one folder or use the -force option" -f $MVVDBNumber)
        }
        return $result.tables
    }
}
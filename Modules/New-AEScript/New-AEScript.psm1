function New-AEScript {
    param (
    [string]$scriptName = $(
    $name = $(read-host "ScriptName pls ");
    if (-not $name) {$(throw "no name supplied")}
    $name),
    [string]$developmentDir = "C:\Users\sdixon\OneDrive - Museums Victoria\development\Adobe Extendscript\Scripts",
    [switch]$UIScript,
    [string]$template = $(if ($UIScript){"UI-Script"} else {"selectedLayersTemplate"}),
    [switch]$overWriteOK
    )
    
    
    $hardLinkTargetFolder = Join-Path $env:APPDATA "Adobe" "After Effects"
    $aeversions = Get-ChildItem $hardLinkTargetFolder -dir|Where-Object{$_.name -match (".*[0-9]+")}
    Write-Host $aeversions
    $latestVersion = 0;
    foreach($n in $aeversions){
        if ([float]$latestVersion -le [float]$n.name){ $latestVersion = $n.name}
    }
    $hardLinkTargetFolder = Join-Path $hardLinkTargetFolder $latestVersion "Scripts"
    # append "scriptUI panels" to the path
    if ($UIScript){ 
        $developmentDir = Join-Path $developmentDir "ScriptUI Panels"
        $hardLinkTargetFolder = Join-Path $hardLinkTargetFolder "ScriptUI Panels"
    }
    # give it the extension
    if (-not($scriptName -match "(.*).jsx$")){
        $scriptName = $scriptName + ".jsx";
    }
    # compile the file and hardlink names
    $newScriptPath = Join-Path $developmentDir $scriptName
    $hardLinkPath = (Join-Path $hardLinkTargetFolder $scriptName)
    
    #get the template
    $templatePath = Join-Path $PSScriptRoot  "$template.txt"; #templates are in the same dir as the PS script
    if (-not(Test-Path $templatePath)){
        throw "Template does not exist" #Silly rabbit
    }
    
    $templateText = Get-Content $templatePath
    $scriptText = @()
    $templateText|ForEach-Object{
        $scriptText += $_.replace("#scriptname#", $scriptName.replace(".jsx", ""))
    }
    # check for pre-existing files
    $okToGo = $true
    if ((Test-Path $newScriptPath) -and (-not $overWriteOK)){
        $okToGo = $(
        Write-Host "$scriptName already exists in $developmentDir" -ForegroundColor DarkYellow;
        write-host "Overwite? " -NoNewline -ForegroundColor Yellow;
        read-host "(y/N)"
        ).ToLower() -match "^y$"
    }
    # do the things
    if ($okToGo){
        try {
            Set-Content -Path $newScriptPath -Value $scriptText
            Write-Host "Created $scriptName in $hardLinkTargetFolder" -ForegroundColor Green
            cmd /c "mklink /h  $hardLinkPath $newScriptPath"
            # New-Hardlink $hardLinkPath $newScriptPath
            Write-host "Hardlinked script to AE Scripts folder $hardLinkTargetFolder" -ForegroundColor Green
        }
        catch {
            Write-Host "An error occured" -ForegroundColor Red
            Write-Host $_ -ForegroundColor DarkRed
        }
    } else {
        Write-host "Script wasn't written." -ForegroundColor DarkYellow
    }
}
function remove-AEScript {
    param (
    [string]$scriptName = $(
    $name = $(read-host "ScriptName pls ");
    if (-not $name) {$(throw "no name supplied")}
    $name),
    [string]$developmentDir = "C:\Users\sdixon\OneDrive - Museums Victoria\development\Adobe Extendscript\Scripts",
    [switch]$UIScript
    )
    
    $hardLinkTargetFolder = Join-Path $env:APPDATA "Adobe" "After Effects"
    
    if (-not($scriptName -match "(.*).jsx$")){
        $scriptName = $scriptName + ".jsx";
    }
    
    $aeversions = Get-ChildItem $hardLinkTargetFolder -dir
    $latestVersion = 0;
    foreach($n in $aeversions){
        if ([float]$latestVersion -le [float]$n.name){ $latestVersion = $n.name}
    }
    $hardLinkTargetFolder = Join-Path $hardLinkTargetFolder $latestVersion "Scripts"
    if ($UIScript){ 
        $developmentDir = Join-Path $developmentDir "ScriptUI Panels"
        $hardLinkTargetFolder = Join-Path $hardLinkTargetFolder "ScriptUI Panels"
    }
    
    $targetScriptPath = Join-Path $developmentDir $scriptName
    $okToGo = $true
    if (! (Test-Path $targetScriptPath)){
        throw "$scriptName does not exist in $developmentDir";
    }
    $okToGo = $(
    Write-Host "Deleting $scriptName from $developmentDir" -ForegroundColor DarkYellow;
    write-host "Are you sure? " -NoNewline -ForegroundColor Yellow;
    read-host "(y/N)"
    ).ToLower() -match "^y$"
    
    if ($okToGo){
        remove-item $targetScriptPath -v
        Write-Host "Deleted $scriptName in $hardLinkTargetFolder"
        remove-item (Join-Path $hardLinkTargetFolder $scriptName) -v
        Write-host "Deleted script in AE Scripts folder $hardLinkTargetFolder"
    } else {
        Write-host "Nothing happened." -ForegroundColor Green
    }
}

function Sync-AEscriptFolder {
    param (
    [string]$developmentDir = "C:\Users\sdixon\OneDrive - Museums Victoria\development\Adobe Extendscript\Scripts"
    )
    $hardLinkTargetFolder = Join-Path $env:APPDATA "Adobe" "After Effects"
    $aeversions = Get-ChildItem $hardLinkTargetFolder -dir
    Write-Host $aeversions
    $latestVersion = 0;
    foreach($n in $aeversions){
        if ([float]$latestVersion -le [float]$n.name){ $latestVersion = $n.name}
    }
    $hardLinkTargetFolder = Join-Path $hardLinkTargetFolder $latestVersion "Scripts"
    Get-ChildItem -R $developmentDir -Exclude ".*" |ForEach-Object{
        if (-not ($_.FullName.replace($developmentDir, "") -match "\\\.")){
            $hardLinkedFile =  $_.FullName.Replace($developmentDir, $hardLinkTargetFolder)
            if ($_ -is [System.IO.DirectoryInfo]){        
                mkdir $hardLinkedFile -ErrorAction SilentlyContinue | out-null           
            } else {
                if (Test-Path $hardLinkedFile){
                    Remove-Item $hardLinkedFile
                }
                New-Item -ItemType HardLink -Path $hardLinkedFile -Value $_.fullname -ErrorAction SilentlyContinue 2>&1 | out-null
            }
        }
    }
    $orphans = @()
    Get-ChildItem $hardLinkTargetFolder -R |ForEach-Object{
        if (-not (Test-Path $_.FullName.Replace($hardLinkTargetFolder, $developmentDir))){
            $orphans += $_
        }
    }
    if ($orphans.length){
        Write-Host "There are some scripts in the AppData dir that arent in the Development Dir" -ForegroundColor DarkYellow
        $orphans|ForEach-Object{
            Write-Host $_.name -ForegroundColor Cyan
        }
        Write-Host "[1] Delete them"
        Write-Host "[2] move them to the Dev dir, and hardlink"
        Write-Host "[3] move them to the Desktop"
        Write-Host "[4] leave them be"
        $choice = Read-Host "U choose pls"
        switch ([int]$choice) {
            1 {
                $orphans|ForEach-Object{
                    Remove-Item -R $_.fullname
                }
            }
            2 {
                $orphans|ForEach-Object{
                    Move-Item $_.FullName $_.FullName.Replace($hardLinkTargetFolder, $developmentDir)
                    New-Hardlink $_.FullName  $_.FullName.Replace($hardLinkTargetFolder, $developmentDir) | out-null
                }
            }
            3{
                $d = Join-Path ([Environment]::GetFolderPath("Desktop")) "Orphaned AEScripts"
                mkdir $d -ErrorAction SilentlyContinue
                $orphans|ForEach-Object{
                    Move-Item $_ $d
                }
                Invoke-Item $d
            }
            Default {
                Write-Host "nothing happened"
            }
        }
    }
}
function New-AEScript {
    param (
    [string]$scriptName = $(
    $name = $(read-host "ScriptName pls ");
    if (-not $name) {$(throw "no name supplied")}
    $name),
    [string]$developmentDir,
    [switch]$UIScript,
    [string]$template = $(if ($UIScript){"UI-Script"} else {"selectedLayersTemplate"}),
    [switch]$overWriteOK,
    [switch]$createHardlinkInAEScriptsFolder
    )
    
    $prefs = getPrefs; 
    if ("" -ne $developmentDir){
        $prefs.developmentDir = $developmentDir
    } 
    if (! (test-path $prefs.developmentDir -ErrorAction SilentlyContinue)) {       
        $prefs.developmentDir = getDDir;
    }
        
    $hardLinkTargetFolder = Join-Path $env:APPDATA "Adobe" "After Effects"
    $aeversions = Get-ChildItem $hardLinkTargetFolder -dir|Where-Object{$_.name -match (".*[0-9]+")}
    
    $latestVersion = 0;
    foreach($n in $aeversions){
        if ([float]$latestVersion -le [float]$n.name){ $latestVersion = $n.name}
    }
    $hardLinkTargetFolder = Join-Path $hardLinkTargetFolder $latestVersion "Scripts"
    
    # append "scriptUI panels" to the path
    if ($UIScript){ 
        $outputDir = Join-Path $prefs.developmentDir "ScriptUI Panels"
        $hardLinkTargetFolder = Join-Path $hardLinkTargetFolder "ScriptUI Panels"
    } else {
        $outputDir = $prefs.developmentDir
    }
    
    # give it the extension
    if (-not($scriptName -match "(.*).jsx$")){
        $scriptName = $scriptName + ".jsx";
    }
    # compile the file and hardlink names
    $newScriptPath = Join-Path $outputDir $scriptName
    if ($createHardlinkInAEScriptsFolder){
        $hardLinkPath = (Join-Path $hardLinkTargetFolder $scriptName)
    }
    
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
        Write-Host "$scriptName already exists in $outputDir" -ForegroundColor DarkYellow;
        write-host "Overwite? " -NoNewline -ForegroundColor Yellow;
        read-host "(y/N)"
        ).ToLower() -match "^y$"
    }
    # do the things
    if ($okToGo){
        try {
            Set-Content -Path $newScriptPath -Value $scriptText
            Write-Host "Created $scriptName in $outputDir" -ForegroundColor Green
            if ($createHardlinkInAEScriptsFolder){
                cmd /c mklink /h "$newScriptPath"  "$hardLinkPath" 
                New-Hardlink $hardLinkPath $newScriptPath
                Write-host "Hardlinked script to AE Scripts folder $hardLinkTargetFolder" -ForegroundColor Green
            }
        }
        catch {
            Write-Host "An error occured" -ForegroundColor Red
            Write-Host $_ -ForegroundColor DarkRed
        }
    } else {
        Write-host "Script wasn't written." -ForegroundColor DarkYellow
    }
    Export-Clixml -Path  (join-path $env:APPDATA "pureandapplied" "newAeScript.dat") -InputObject $prefs
}

function getPrefs(){
    $prefs = @{}
    $prefs = import-clixml (join-path $env:APPDATA "pureandapplied" "newAeScript.dat") -ErrorAction SilentlyContinue;
    return $prefs
}

function getDDir(){
    Add-Type -AssemblyName System.Windows.Forms
    $browser = New-Object System.Windows.Forms.FolderBrowserDialog
    $null = $browser.ShowDialog()
    return $browser.SelectedPath
}
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
if ($host.Name -eq 'ConsoleHost')
{
  
  # ----------------------------------Elevated ------------------------------------------- 
  
  $isElevated = $false
  #//find out if the session is elevated
  If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){
    # Import-Module "elevated"
    $isElevated = $true
  } Else {
    $isElevated = $false
  }
  
  # ----------------------------------Modules and Aliases--------------------------------- 
  Import-Module "copy-text"; #enables piping to the clipboard
  Import-Module "moveCursor"
  Import-Module "chocolist"

  set-alias grep select-string
  set-alias which Get-Command
  set-alias cx copy-text
  
  # ----------------------------------Prompt------------------------------------------- 
  function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(850)
    # Write-Host ( $env:USERNAME + "@" + $env:COMPUTERNAME + " ") -nonewline -ForegroundColor Yellow
    $d8t = (Get-Date)
    $d8tLngth = ($d8t -as [string]).length
    $pathFG = "Gray"
    $pathBG = "DarkCyan"
    $promptFG = "White"
    $timeBG = "DarkCyan"
    $bgc = "Blue"
    $timeFG = "Cyan"
    $curs = ">"
    if ($isElevated){
      $bgc = "DarkRed"
      $pathBG = "DarkRed"
      $timeBG = "DarkRed"
      $timeFG = "Yellow"
    } 
    Write-Host ("{0,$(0 - $($host.UI.rawui.windowSize.width) + $d8tLngth + 1)}" -f $(get-location)) -nonewline -ForegroundColor $pathFG -BackgroundColor $pathBG
    Write-Host ("{0} " -f $(Get-Date)) -foregroundcolor $timeFG -BackgroundColor $timeBG
    Write-Host $curs -BackgroundColor $bgc -ForegroundColor $promptFG -nonewline
    # Write-VcsStatus
    
    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
  }
  
  # ----------------------------------Completion & History ------------------------------------------- 
  Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
  
  # if you don't already have this configured...
  # trying this out
  Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
  Set-PSReadlineOption -ShowToolTips
  if (! $isElevated){
  Install-GuiCompletion # better completion with ^space
  # colours for guicompletion
  $GuiCompletionConfig.Colors = @{
    "BorderTextColor" = "Yellow"
    "TextColor" = "White"
    "SelectedTextColor" = "Black"
    "SelectedBackColor" = "Gray"
    "BackColor" = "Black"
    "FilterColor" = "Yellow"
    "BorderBackColor" = "DarkGray"
    "BorderColor" = "DarkGray"
  }
}
  
  # ----------------------------------CLI weather------------------------------------------- 
  
  function Get-Weather {
    param (
    [string]$L
    )
    Write-host (Invoke-WebRequest "http://wttr.in/$L" ).content
  }
}

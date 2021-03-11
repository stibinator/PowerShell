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
    Import-Module "elevated"
    $isElevated = $true
  } Else {
    $isElevated = $false
  }
  
  # ----------------------------------Modules and Aliases--------------------------------- 
  
  # Import-Module "aerenderMulti" 2>$null; #aerender controller
  Import-Module "copy-text"; #enables piping to the clipboard
  Import-Module "moveCursor"
  
  set-alias grep select-string
  set-alias which Get-Command
  set-alias cx copy-text
  # $DMYHMS = '%d-%m-%y_%H-%M-%S'
  $Global:MyDocs = Get-Item ([environment]::getfolderpath("MyDocuments")) -ErrorAction SilentlyContinue
  $Global:Desktop = Get-Item([environment]::getfolderpath("Desktop")) -ErrorAction SilentlyContinue
  $Global:Work = get-item (Join-Path $Mydocs "Current Work") -ErrorAction SilentlyContinue
  $Global:HDir = get-item("H:\My Documents") -ErrorAction SilentlyContinue
  # $PSScripts = Join-Path $MyDocs WindowsPowerShell"
  # $reusableDir = Join-Path $MyDocs "work\reuseable"
  
  # ----------------------------------Prompt------------------------------------------- 
  # Set up a simple prompt, adding the git prompt parts inside git repos
  function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(850)
    #Write-Host ( $env:USERNAME + "@" + $env:COMPUTERNAME + " ") -nonewline -ForegroundColor Yellow
    $d8t = (Get-Date)
    $d8tLngth = ($d8t -as [string]).length
    $pathFG = "Gray"
    $pathBG = "DarkGray"
    $promptFG = "White"
    $timeBG = "DarkGray"
    if ($isElevated){
      $bgc = "DarkRed"
      $curs = ">"
      $timeFG = "Yellow"
    } else {
      $bgc = "Blue"
      $timeFG = "Cyan"
      $curs = ">"
    }
    Write-Host ("{0,$(0 - $($host.UI.rawui.windowSize.width) + $d8tLngth + 4)}" -f $(get-location)) -nonewline -ForegroundColor $pathFG -BackgroundColor $pathBG
    Write-Host ("{0} " -f $(Get-Date)) -foregroundcolor $timeFG -BackgroundColor $timeBG
    Write-Host $curs -BackgroundColor $bgc -ForegroundColor $promptFG -nonewline
    # Write-VcsStatus
    
    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
  }
  # ----------------------------------restore profile------------------------------------------- 
  
  function Restore-Profile {
    @($Profile.AllUsersAllHosts,
    $Profile.AllUsersCurrentHost,
    $Profile.CurrentUserAllHosts,
    $Profile.CurrentUserCurrentHost
    ) | ForEach-Object {
      if(Test-Path $_){
        Write-Host "Running $_" -foregroundcolor Magenta
        . $_
      }
    }
  }
  # ----------------------------------HISTORY------------------------------------------- 
  # $MaximumHistoryCount = 31KB
  # $ImportedHistoryCount = 0
  # $HistoryDirPath = Join-Path ([environment]::getfolderpath("ApplicationData")) "PS_History"
  # $HistoryFileName = "history.clixml"
  # $historyFile = join-path $HistoryDirPath $HistoryFileName
    
  # if (!(Test-Path $HistoryDirPath -PathType Container))
  # {   New-Item $HistoryDirPath -ItemType Directory }
    
  # Register-EngineEvent PowerShell.Exiting -Action {
  #   $TotalHistoryCount = 0
  #   Get-History | Where-Object {$TotalHistoryCount++;$true}
  #   $RecentHistoryCount = $TotalHistoryCount - $ImportedHistoryCount
  #   $RecentHistory = Get-History -Count $RecentHistoryCount
  #   if (!(Test-path ($historyFile)))
  #   {
  #     Get-History | Export-Clixml ($historyFile)
  #   } else {
  #     $OldHistory = Import-Clixml ($historyFile)
  #     $NewHistory = @($OldHistory + $RecentHistory)
  #     $NewHistory | Export-Clixml ($historyFile)
  #   }
  # } 1>$null
  # if (Test-path ($historyFile))
  # {
  #   Import-Clixml ($historyFile) | Where-Object {$count++;$true} |Add-History
  #   # Write-Host -Fore Green "Loaded $count history item(s)."
  #   $ImportedHistoryCount = $count
  # }
  
  Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
  # ----------------------------------Completion------------------------------------------- 
  
  # if you don't already have this configured...
  # trying this out
  Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
  Set-PSReadlineOption -ShowToolTips
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
    "BorderColor" = "DarkGray"}
  }
  
  # ----------------------------------CLI weather------------------------------------------- 
  
  function Get-Weather {
    param (
    [string]$L
    )
    Write-host (Invoke-WebRequest "http://wttr.in/$L" ).ParsedHtml.body.outerText -ForegroundColor Yellow
  }

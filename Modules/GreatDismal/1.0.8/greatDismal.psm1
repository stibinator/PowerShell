function get-DismalLockscreen{
    param (
    [string[]]$adjectives = @(),
    [string[]]$nouns = @(),
    [string]$dismalFolder = (join-path $env:APPDATA "\great dismal\"),
    [string]$logfile = (join-path $dismalFolder "log.txt"),
    [int]$safeSearch = 0,
    [switch]$showpic,
    [switch]$showLog,
    [switch]$noLog,
    [switch]$install,
    [switch]$uninstall,
    [switch]$checkForUpdates
    )
    
    write-host "logfile at $logfile"
    $lastUpdate = $false;
    $shouldUpdate = $false;
    if (test-path $logfile){
        $lastUpdate = (Get-Content $logfile) | Where-Object {$_ -match "([^-]*)->\s*updating"}
        if ($lastUpdate){
            # check every week, future versions might slow this down a bit
            $shouldUpdate = (get-date $Matches[1]) -lt ((get-date).AddDays(-7))
        } else {
            $shouldUpdate = $true;
        }
    } 
    if ($shouldUpdate) {
        write-GDLog "updating GD" -logfile $logfile
        Update-module "GreatDismal"
    }

    # do the stuffs
    # installation hoo-hah
    if (! (test-path $dismalFolder)){mkdir $dismalFolder}
    $dismalPic = Join-Path $dismalFolder "greatDismal.jpg"
    
    if ($install){ 
        install-GreatDismal -adjectives $adjectives -nouns $nouns -dismalFolder $dismalFolder -scriptPath $scriptPath -logfile $logfile -nolog $nolog -safeSearch $safeSearch
    } 
    
    if ($showpic) {
        #user wants to see the current pic
        Invoke-Item $dismalPic
    } elseif ($showLog){
        #user wants to see the log
        Get-Content $logfile
    } elseif ($uninstall){
        #user wants to see the log
        uninstall-GreatDismal -logfile $logfile -dismalFolder $dismalFolder;
    }else {
        #get the pic and set the screen
        get-dismalpicFortheDay -adjectives $adjectives -nouns $nouns -dismalPic $dismalPic -logFile $logfile -nolog $nolog  -safeSearch $safeSearch;
    }
}

function get-dismalpicFortheDay {
    param (
    [string[]]$adjectives = @(),
    [string[]]$nouns = @(),
    [string]$dismalPic,
    [string]$logfile,
    [bool]$nolog,
    [int]$safeSearch = 0
    )
    Write-Host "getting some fresh despair for you"
    
    $key = "48efbaf66f9bf4b1bf2d0b04c46b02b1"
    $scrt = "9f5ab5c8abc77684"
    if ($adjectives.Length -eq 0){
        $adjectives = @(
        "abandoned", "boring", "broken", "brutalist", "burnt", "creepy", "crumbling", "decaying", "depressing", "desolate", "diseased", "dismal", "dreary", "dull", "dumped", "ghostly", "gloomy", "industrial", "infested", "messy", "miserable", "muddy", "neglected", "overgrown", "poisoned", "rotten", "rotting", "ruined", "scattered", "shattered", "spoiled", "stained", "tangled", "toxic", "trashed", "ugly", "untidy", "wrecked"
        );
    }
    if ($nouns.Length -eq 0){
        $nouns=@("apartment block", "barbed wire", "bin", "building", "bunker", "carcass", "cell", "concrete", "concrete", "cubicle", "despair", "dirt", "dump", "dumpster", "estate", "factory", "factory", "field", "fog", "freeway", "garbage", "gaol", "grave", "hovel", "jail", "junk", "landscape", "mud", "office", "paddock", "pit", "plastic", "puddle", "razor wire", "road", "rubbish", "rubble", "ruin", "spill", "streetscape", "swamp", "tower", "town", "trash", "vomit", "wall", "wasteland", "weeds", "wreck"
        );
    }
    $attempts = 0;
    if ($safeSearch -gt 0){
        $safeSearchStr = "&safe_search="+$safeSearch
    } else {
        $safeSearchStr = ""
    }

    while ((! $photogURL) -and ($attempts -lt 64)){
        $picfortheday = @($adjectives[(Get-Random($adjectives.Length))], $nouns[(Get-Random($nouns.Length))]) -join ",";
        $result = Invoke-RestMethod -URi  ("http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key={0}&secret={1}&tags={2}&tag_mode=all&sort=interestingness-desc&media=photos&format=rest&extras=url_k{3}" -f $key, $scrt, $picfortheday, $safeSearchStr) -Method Get
        $pics = $result.rsp.photos.photo;
        if ($pics.length -gt 0){
            write-GDLog ("looking for pics of {0}, found {1}" -f ($picfortheday.replace(",", " and ")),  $pics.length) -logFile $logfile -nolog $nolog
            $randompics = 0;
            while (($null -eq $photogURL) -and ($randompics -lt $pics.length) ){
                $randoPhoto = Get-Random $pics.Length;
                $photogURL = $pics[$randoPhoto].url_k;
                $randompics++
            }
            if ($null -ne $photogURL){
                write-GDLog ("found a photo at {0}" -f $photogURL) -logFile $logfile -nolog $nolog
            } else {
                write-GDLog ("no url found. Trying another search") -logFile $logfile -nolog $nolog
            }
            $photoTitle = $pics[$randoPhoto].title;
        } else {
            write-GDLog ("{0} - didn't find any pics of {1}" -f (get-date), ($picfortheday.replace(",",  " and "))) -logFile $logfile -nolog $nolog
        }
        $attempts++;
    }
    (New-Object Net.webclient).DownloadFile($photogURL, $dismalPic)
    write-GDLog ("downloaded `"{0}`"" -f $photoTitle) -logFile $logfile -nolog $nolog
    
    Set-LockscreenWallpaper -LockScreenImageValue $dismalPic -logfile $logfile;
}

function Set-LockscreenWallpaper {
    # this was adapted from
    # https://abcdeployment.wordpress.com/2017/04/20/how-to-set-custom-backgrounds-for-desktop-and-lockscreen-in-windows-10-creators-update-v1703-with-powershell/
    # The Script sets custom background Images for the Lock Screen by leveraging the new feature of PersonalizationCSP that is only available in 
    # the Windows 10 v1703 aka Creators Update and later build versions #
    # Applicable only for Windows 10 v1703 and later build versions #
    
    param(
    [string]$LockScreenImageValue,
    [string]$logfile
    )
    
    $RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
    
    $LockScreenPath = "LockScreenImagePath"
    $LockScreenStatus = "LockScreenImageStatus"
    $LockScreenUrl = "LockScreenImageUrl"
    $StatusValue = "1"
    
    If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){
        
        IF(!(Test-Path $RegKeyPath))
        
        {
            
            New-Item -Path $RegKeyPath -Force | Out-Null
            
            New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
            New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
            
        }
        
        ELSE {
            
            New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $value -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
            New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
        }
    } else {
        write-GDLog ("Error: not running as Admin, can't set the registry.") -logFile $logfile -nolog $nolog
    }
}

function install-GreatDismal {
    param(
    [String]$logfile = (join-path $env:APPDATA "\great dismal\log.txt"),
    [string]$dismalFolder = (join-path $env:APPDATA "\great dismal\"),
    [int]$safeSearch = 0,
    [string[]]$adjectives = @(),
    [string[]]$nouns = @(),
    [bool]$nolog,
    [bool]$phoneHome
    )
    # check to see if user is admin
    if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){
        # is admin, we're good to install
        $divider = "`n" + ("-" * (Get-Host).ui.rawui.windowsize.width) + "`n"; # trick to make a row of dashes the width of the window
        write-host ($divider) -foregroundColor "yellow"
        Write-Host "This will install GreatDismal on your machine and it will download a random dismal login screen every time you log in" -ForegroundColor DarkYellow
        Write-Host "Note that the contents of the pictures are beyond the control of the developer, and may be " -NoNewline -ForegroundColor DarkYellow
        Write-Host "unsafe for work." -ForegroundColor DarkYellow -BackgroundColor DarkRed
        write-host ($divider) -foregroundColor "yellow"

        # define the workstation unlock as the trigger
        $stateChangeTrigger = Get-CimClass -Namespace ROOT\Microsoft\Windows\TaskScheduler -ClassName MSFT_TaskSessionStateChangeTrigger
        $trigger = New-CimInstance -CimClass $stateChangeTrigger -Property @{
            StateChange = 8  # TASK_SESSION_STATE_CHANGE_TYPE.TASK_SESSION_UNLOCK (taskschd.h)
        } -ClientOnly
        
        # Create a task scheduler event
        $argument = "-WindowStyle Hidden -command `"import-module 'GreatDismal'; get-DismalLockscreen -logfile '{0}' -dismalFolder '{1}'{2}{3}{4}{5}`"" -f `
            $logfile, `
            $dismalFolder, `
            $(if ($adjectives.Length -gt 0){" -adjectives ({0})" -f ($adjectives -join ", ")} else {""}), `
            $(if ($nouns.Length -gt 0){" -nouns ({0})" -f ($nouns -join ", ")} else {""}), `
            $(if ($phoneHome){" -checkForUpdates"} else {""}), `
            $(if ($safeSearch -gt 0){" -safeSearch " + $safeSearch} else {""})
        $action = New-ScheduledTaskAction -id "GreatDismal" -execute 'Powershell.exe' -Argument $argument
        $settings = New-ScheduledTaskSettingsSet -Hidden -StartWhenAvailable -RunOnlyIfNetworkAvailable
        Write-Host "for this script to work it needs elevated privileges" -BackgroundColor DarkBlue
        $Credential = Test-Credential
        if ($Credential){
            # actually install the shiz
            Write-Host "Username checks out." -ForegroundColor Green
            write-GDLog "Unregistering existing scheduled task" -logfile $logfile -nolog $nolog
            Unregister-ScheduledTask -TaskName "greatDismal" -ErrorAction SilentlyContinue
            Register-ScheduledTask `
            -TaskName "greatDismal" `
            -User $Credential.username `
            -Action $action `
            -Settings $settings `
            -Trigger $trigger -RunLevel Highest `
            -Password $Credential.GetNetworkCredential().Password `
            -taskPath "\pureandapplied\"
        }
        if ($? -and (Get-ScheduledTask -TaskName "GreatDismal" -ErrorAction SilentlyContinue)){
            write-GDLog "GreatDismal is installed" -colour "Green" -logFile $logfile -nolog $nolog
        } else {
            throw "Bollocks. Something went wrong. Computers suck."
        }
    }  else {
        # not admin
        Write-Host "You need run this script as an Admin to install it" -BackgroundColor Red -ForegroundColor Yellow
        throw "Computer says no."
    }
}

function uninstall-GreatDismal {
    param(
    [string]$logfile,
    [string]$dismalFolder
    )
    if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){
        $RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
        remove-item -Path $RegKeyPath -Force -Recurse| Out-Null;
        Unregister-ScheduledTask -TaskName "greatDismal" -ErrorAction SilentlyContinue;
        Remove-Item  $dismalFolder -Recurse -ErrorAction SilentlyContinue;
        $scriptPath = (get-item $myInvocation.ScriptName).Directory
        # remove-module doesn't seem to work for psgallery modules. So we do it manually
        # just check that we're actually removing the greatdismal folder
        if ($scriptPath.name -eq "GreatDismal"){
            Write-host "You have to manually remove the module now. Just delete the GreatDismal folder." -BackgroundColor Yellow -ForegroundColor Red
            Invoke-Item $scriptPath; #open the folder containing the module folder (usually ~\Documents\WindowsPowershell\Modules)
        }
    } else {
        Write-host "you need to run this script as admin to uninstall it" -BackgroundColor Red -ForegroundColor Yellow
        throw "Computer says no."
    }
    
}
function Test-Credential {
    # check password, allowing multiple attemps
    $againWithThePassword = $true;
    $usernameChecksOut = $false;
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement
    $DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('machine',$env:COMPUTERNAME)
    
    while ((! $usernameChecksOut) -and $againWithThePassword){
        $Credential = Get-Credential -ErrorAction SilentlyContinue
        if ($null -eq $Credential){
            Write-Warning "You didn't give me any credentials. I can't help you if you won't help me."
            $againWithThePassword = ((read-host "Again with the password? Y/n").ToLower() -ne "n")
        } else {
            $usernameChecksOut = $DS.ValidateCredentials($Credential.UserName, $Credential.GetNetworkCredential().Password)
            if ($usernameChecksOut){
                return $Credential
            } else {
                Write-Warning "Username and / or password is incorrect. Soz.";
                $againWithThePassword = ((read-host "Again with the password? Y/n").ToLower() -eq "n")
            }
        }
        if (! $againWithThePassword){
            return $false
        }
        Start-Sleep 1
    }
}

function write-GDLog  {
    param (
    [string]$Msg,
    [string]$colour = "White",
    [string]$logfile, 
    [bool]$nolog
    )

    if ((-not $nolog) -and ($null -ne $logfile)){
        $date = Get-date -f "dd/MM/yyyy HH:mm:ss"
        if (! (test-path $logfile )){set-content $logfile "The Great Dismal Log"}
        # trim the log if it gets too long 64k is long enough right?
        if ((get-item $logfile).length -gt 64kb){
            # get the last 20 lines
            $oldlog = (Get-Content $logfile)[-20..-1] 
            # carry over the last update check
            $lastUpdate = ""
            $lastUpdate = (Get-Content $logfile) | Where-Object {$_ -match "([^-]*)->\s*UpdateCheck"}
            if ($lastUpdate){$lastUpdate = $lastUpdate[-1]}
            Set-Content $logfile ("The Great Dismal Log`n" + $date + "-> " + "Trimmed log")
            Add-Content $logfile $oldlog
            Add-Content $logfile $lastUpdate
        }
        add-content $logfile ("" + $date + "-> " + $msg)
    }
    Write-Host $Msg -foregroundColor $colour
}

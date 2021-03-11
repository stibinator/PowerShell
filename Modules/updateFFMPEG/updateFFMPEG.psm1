function msg($msg)
{
  $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0 , 3
  $Host.UI.Write( "                                                                                                     ")
  $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0 , 3
  Write-Host -Fore Magenta "Updating FFMPEG"
  $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0 , 4
  $Host.UI.Write( "                                                                                                     ")
  $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0 , 4
  Write-Host -Fore Red $msg
}

function update-FFMPEG {
  param(
    [switch]$force
  )
  $7z = get-command 7z
  if (! $7z){throw "This script need 7z.exe to run. Please install it"}
  # change this to -Format MM-yyy for once a month,
  # or HH-dd-MM-yyyy for once an hour
  $theDate = (Get-Date -Format dd-MM-yyyy)
  # this will be the ffmpeg executable directory:
  $ffmpegDir = 'C:\Program Files\ffmpeg\'
  mkdir $ffmpegDir -ErrorAction SilentlyContinue;
  #I like to put all my command line shit in here
  $commandLineDir = 'C:\usr\local\bin\'
  mkdir $commandLineDir -ErrorAction SilentlyContinue;
  # Zeranoe's latest build:
  $URL = "https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-latest-win64-static.zip"
  write-host  "Updating FFMPEG"
  # check to see if it has been updated today
  if ((! $force) -and (test-Path ($ffmpegDir + "last_update-" + $theDate))){
    Write-Host "already updated ffmpeg today" -foregroundcolor "Red"
  } else {
    rm ($ffmpegDir + "last_update-*") -ErrorAction SilentlyContinue
    New-Item ($ffmpegDir + "last_update-" + $theDate) -type file 2>&1 1>$null
    write-host ( "Checking online for new FFMPEG version")
    $downloadPath = ($ffmpegDir + 'latest.zip')

    # check to see if ImageMagick has been installed
    $IMVersion = (ls 'C:\Program Files\ImageMagick*\ffmpeg.exe')

    # delete any old downloads
    write-host ( "deleting old downloads")
    rm $downloadPath -ErrorAction SilentlyContinue
    # look in the ffmpeg directory for latest current versions
    $f=(ls $ffmpegDir -filter "ffmpeg-*"| ?{ $_.PSIsContainer }| sort lastWriteTime)
    if ($f.length -gt 0) {
      # there are current versions locally
      # get the last write time of the latest version
      $D = (get-date $f[-1].LastWriteTime -format "yyyyMMdd HH:mm:ss")
      write-host ( "last version was $D, downloading...")
      # download a newer version if it exists (--time-cond)
      Invoke-WebRequest $URL -OutFile $downloadPath
    } else {
      # no current versions
      write-host ( "downloading for the first time")
      Invoke-WebRequest $URL -OutFile $downloadPath
    }
    # if we downloaded something, time to install it
    if (test-Path $downloadPath){
      # there was a new version available
      write-host ( "New build of FFMPEG found, installing") -foregroundcolor "yellow"
      # unpack it to the ffmpeg program dir
      #(silently, remove "2>&1 1>$null" if you want to know what it's doing)

      write-host "expanding" -foregroundcolor "yellow"
      Expand-Archive "$downloadPath" -OutputPath ("$ffmpegDir" + "_new")# 2>&1 1>$null
      if ($?){
        # delete the current binaries
        rm -R $ffmpegDir
        mv ("$ffmpegDir" + "_new") $ffmpegDir
        # delete the old links
        ls $ffmpegDir -file -filter "ff*.exe"|%{rm $_.fullname}
        if (test-path $commandLineDir -ErrorAction SilentlyContinue){
          ls $commandLineDir -file -filter "ff*.exe"|%{rm $_.fullname}
        }
        # update the latest version
        $f=(ls $ffmpegDir -directory -filter "ffmpeg-*"|sort lastWriteTime)
        # make new symlinks, er hardlinks, whateverr
        ls ($f[-1].fullname + "\bin")|%{
          New-Hardlink ($ffmpegDir + $_.name) $_.FullName
          if (test-path $commandLineDir -ErrorAction SilentlyContinue){
            New-Hardlink ($commandLineDir + $_.name) $_.FullName
          }

        }
        # Imagemagick brings its own version of ffmpeg,
        # which ends up on the PATH, so replace it with a hardlink to this one
        #-------if you don't want this cut here ------
        if ($IMVersion.length -gt 0) {
          write-host  ( "replacing the Image Magick version of FFMPEG")
          if (Test-Path ($IMVersion.fullname + ".dist")) {
            rm $IMVersion #already made a backup
          } else {
            mv $IMVersion ($IMVersion.fullname + ".dist")
          }
          New-Hardlink $IMVersion.fullname ($ffmpegDir + "ffmpeg.exe")`
          -ErrorAction SilentlyContinue
        }
        #-------to here-------------------------
        rm $downloadPath 2>&1 1>$null
        #-------Update Path variable
        $p=(("C:\usr\local\bin;" + (ls Env:\Path).value).split(";"))
        Set-Content -path Env:\Path -value (($p|Get-Unique) -join ";")
      }
    } else {
      write-host ( "Current build of FFMPEG is up to date.") -foregroundcolor "green"
    }
  }
}

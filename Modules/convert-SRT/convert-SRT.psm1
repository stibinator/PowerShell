function convert-SRTtoMVFormattedASS{
  param(
  [Parameter(Mandatory=$True,ValueFromPipeLine=$True)]
  $inputfile,
  [string] $outputfile,
  [Parameter(Mandatory=$True)][ValidateSet('Landscape','SocialsLandscape', 'Portrait-9x16', 'Portrait4x5', 'Landscape-TextBox','TitleSafeLandscape')][string] $template,
  $pagebreakPos = 20,
  [string]$defaultStyle = "Dialogue",
  [bool]$dontRemoveTemp = $False,
  [bool]$zapSquareBrackets = $False
  )
  
  $PlayResX =  1920
  $PlayResY =  1080
  $Name = "Style: Default" 
  $Fontname = "Source Sans Pro"
  $Fontsize = "64"
  $PrimaryColour = "&Hffffff"
  $SecondaryColour = "&Hffffff"
  $OutlineColour = "&H000000"
  $BackColour = "&H000000"
  $Bold = "0"
  $Italic = "0"
  $Underline = "0"
  $BorderStyle = "1"
  $Outline = "1"
  $Shadow = "0"
  $Alignment = "2"
  $MarginL = "10"
  $MarginR = "10"
  $MarginV = "16"
  $AlphaLevel = "0"
  $Encoding = "0"
  
  write-host ("using template $template")
  switch ($template) {
    'SocialsLandscape'{
      $PlayResX = "1920"
      $PlayResY = "1080"
      $Fontsize = "72"
      $marginV = "16"
    } 
    'Portrait-9x16'{
      $PlayResX = "1080"
      $PlayResY = "1920"
      $Fontsize = "64"
      $marginV = "60"
    } 
    'Portrait4x5'{
      $PlayResX = "1080"
      $PlayResY = "1920"
      $Fontsize = "100"
      $marginV = "60"
    } 
    'Landscape-TextBox'{
      $PlayResX = "1920"
      $PlayResY = "1080"
      $Fontsize = "64"
      $BorderStyle = "3"
      $marginV = "16"
    } 
    'TitleSafeLandscape'{
      $PlayResX = "1920"
      $PlayResY = "1080"
      $Fontsize = "72"
      $marginV = "60"
    }
  }
  $HeaderTemplate = "[Script Info]`nScriptType: v4.00+`nPlayResX: $PlayResX`nPlayResY: $PlayResY`n`n[V4+ Styles]`nFormat: $Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, AlphaLevel, Encoding`n$Name, $Fontname, $Fontsize, $PrimaryColour, $SecondaryColour, $OutlineColour, $BackColour, $Bold, $Italic, $Underline, $BorderStyle, $Outline, $Shadow, $Alignment, $MarginL, $MarginR, $MarginV, $AlphaLevel, $Encoding`n[Events]`n"
  
  
  $inputfile = get-item $inputfile -ErrorAction silentlycontinue
  if (! ($?)){
    Write-Host ("Could not get subtitle file {0}" -f $inputfile) -ForegroundColor Red
  } else {
    $tempASSFile = $inputfile.name.replace($inputfile.Extension, "_assTemp.ass")
    if (! $outputfile){$outputfile = $inputfile.fullname.replace(".srt", ".ass")}
    Remove-Item $outputfile -ErrorAction silentlycontinue
    & ffmpeg.exe -y -i $inputfile.fullname $tempASSFile -loglevel error
    if (! ($?)){
      Write-Host "could not convert srt file" -ForegroundColor Red
    } else {
      set-content $outputfile $HeaderTemplate -encoding UTF8
      $writeDialog = $false
      $convertedCount = 0;
      # -------start looping through file ---------------------------
      Get-Content $tempASSFile -encoding UTF8|ForEach-Object{
        if ($_ -match "\[Events\]"){
          #wait for the [events] tag so we don't write the header
          $writeDialog = $true;
          #flag that next time round it's time to start writing line
          write-host ("found events tag {0}" -f $_)
        } else {
          if ($writeDialog){
            $line = $_
            $skipLine = $false
            #we've seen the [events] tag
            $pageBreakLine = ($_ -match  "^(([^,]*,){9})([^\\]*)\\N(.+)")
            #(nine comma separated colums)(the payload first line)\N(payload second line)
            if ($pageBreakLine){
              #found a line with a pagebreak
              #Example $Matches
              #Name                           Value
              #----                           -----
              #0                              Dialogue: 0,0:00:54.34,0:00:58.47,Dialogue,,0,0,0,,while studying zoology and\Ngeology as Austral Coaching
              #1                              Dialogue: 0,0:00:54.34,0:00:58.47,Dialogue,,0,0,0,,
              #2                              ,
              #3                              while studying zoology and
              #4                              geology as Austral Coaching
              
              if  ($Matches[3].length -lt $pagebreakPos){
                $line = $Matches[1] + $Matches[3] + " " + $Matches[4]
                write-host ("lengthened {0}" -f $line)
              }
            }
            if($zapSquareBrackets -and ($line -match "^(([^,]*,){9})(\[[A-Z ]*\])$")){
              Write-Host ("deleting line {0}" -f $Matches[3])
              $line = $Matches[1]
              $skipLine = $true
            }
            #swap custom style labels
            if (! ($defaultStyle -eq "Dialogue")){
              $line = $line  -replace '(^Dialogue:[^,]+,[^,]+,[^,]+,)Default', ('$1' + $defaultStyle)
              $convertedCount += 1;
            };
            if (! $skipLine){
              Add-Content $outputfile $line -encoding UTF8
            }
            # had an IO problem when writing longer files, so I had to add this.
            Start-Sleep -Milliseconds 10 
          }
        }
      }
    }
    if ($convertedCount){write-host ("converted {0} lines from Dialogue to {1}" -f $convertedCount, $defaultStyle)};
    if (! ($dontRemoveTemp)){ Remove-Item $tempASSFile -ErrorAction silentlycontinue}
  }
}

function Convert-MovieToSubtitledVersion{
  param(
  [Parameter(Mandatory=$True,ValueFromPipeLine=$True)]$inputfilePath,
  $subtitlesFilePath,
  $outputfile,
  [ValidateSet('Landscape','SocialsLandscape', 'Portrait-9x16', 'Portrait4x5', 'Landscape-TextBox','TitleSafeLandscape')]
  [string]$template = 'Landscape',
  [int]$pagebreakPos = 18,
  [int]$crf = 20,
  [ValidateSet('placebo', 'veryslow', 'slower', 'slow', 'medium', 'fast', 'veryfast', 'superfast', 'ultrafast')][string]$preset = "slow",
  [ValidateSet('film', 'animation', 'grain', 'stillimage', 'fastdecode', 'zerolatency')][string]$tune = $null,
  [string]$pixFmt = 'yuv420p',
  [ValidateSet('high', 'main', 'baseline')][string]$profileV = "main",
  [switch]$y,
  [switch]$n,
  [string]$defaultStyle = "Dialogue",
  [switch]$dontRemoveTemp,
  [switch]$webm,
  [switch]$zapSquareBrackets
  )
  
  $inputfile = get-item $inputfilePath -ErrorAction silentlycontinue
  if ($y -and $n){throw "choose either -y or -n"}
  
  Write-Host ("processing {0}" -f $inputfile.name) -ForegroundColor Green
  $continue = $True
  if (! $?){
    Write-Host ("Can't find input file {0}" -f $inputfilePath) -ForegroundColor Red
  } else {
    if (! $outputfile){
      if ($webm){$ext = ".webm"} else {$ext = ".mp4"}
      $outputfile = $inputfile.fullname.replace($inputfile.Extension, "_subs$ext")
    }
    if (test-path $outputfile){
      if ($y){
        write-host "Overwriting current subtitled version" -BackgroundColor Yellow -ForegroundColor DarkRed
      } else {
        if ($n){
          Write-Host "skipping currently existing file" -ForegroundColor Blue
          $continue = $false
        }
      }
    } else {
      # touch the file to avoid race conditions during multi-head renders
      set-content $outputfile $null 
      # $outputfile will always exist after this point. 
      # Either it used to exist and we're overwriting or skipping, 
      # or it now exists as empty file
    }
    # continue if overwriting, else skipping
    if ($continue){
      if ($subtitlesFilePath){
        $subtitlesFile = get-item $subtitlesFilePath -ErrorAction SilentlyContinue
      } else {
        $subtitlesFile = get-item ($inputfile.fullname.replace($inputfile.Extension, ".srt")) -ErrorAction SilentlyContinue
      }
      if (! $?){
        Write-Host ("Can't find subtitle file {0}" -f $subtitlesFilePath) -ForegroundColor Red
      } else {
        $tempSubFile = $inputfile.name.replace('"', '').replace("'", '').replace(",", "").replace(";", "").replace($inputfile.Extension, "_subsTemp.ass")
        & convert-SRTtoMVFormattedASS $subtitlesFile -outputfile $tempSubFile -pagebreakPos $pagebreakPos -template $template -defaultStyle $defaultStyle -dontRemoveTemp $dontRemoveTemp -zapSquareBrackets $zapSquareBrackets
        Write-Host "writing output: " -NoNewline -ForegroundColor Green;
        Write-Host $outputfile -ForegroundColor Cyan;
        if ($webm){
          & ffmpeg.exe -hide_banner -loglevel warning -stats -y -i $inputfile -pix_fmt $pixFmt -crf $crf -b:v 0 -b:a 128k -vf ("ass='" + $tempSubFile + "'") $outputfile
        } else {
          if ( "" -eq $tune ){ 
            Write-Host "ffmpeg.exe -hide_banner -loglevel warning -stats -y -i '$inputfile' -pix_fmt $pixFmt -profile:v $profileV -crf $crf -preset $preset $tuneSetting -vf ass='$tempSubFile' '$outputfile'"
            & ffmpeg.exe -hide_banner -loglevel warning -stats -y -i $inputfile -pix_fmt $pixFmt -profile:v $profileV -crf $crf -preset $preset -vf ass=$tempSubFile $outputfile
          } else {
            Write-Host "ffmpeg.exe -hide_banner -loglevel warning -stats -y -i '$inputfile' -pix_fmt $pixFmt -profile:v $profileV -crf $crf -preset $preset $tuneSetting -vf ass='$tempSubFile' '$outputfile'"
            & ffmpeg.exe -hide_banner -loglevel warning -stats -y -i $inputfile -pix_fmt $pixFmt -profile:v $profileV -crf $crf -preset $preset -tune $tune -vf ass=$tempSubFile $outputfile
          } 
        }
        if (! ($dontRemoveTemp)) {
          Remove-Item $tempSubFile
        }
      }
    }    
  }
}

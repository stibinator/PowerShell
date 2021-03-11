function test-ImageSequence{
  Param ($searchFolder = ".\",
  [int]$startFrame,
  [switch]$removeDodgyPngs
  )
  
  $badfiles = @();
  $folder = (get-item $searchFolder)
  $firstFrame = $null
  $lastframe =  $removedFrameCount = 0
  Write-Host "Assessing Sequence" -ForegroundColor Green
  Get-ChildItem $folder -File|ForEach-Object{
    if ($_.Name -match "(\d+)"){ 
      #only check numbered files
      $serial = [int]$Matches[1]
      if ($null -eq $startFrame -or $serial -ge $startFrame){
        if (($null -eq $firstFrame) -or ($firstFrame -gt $serial)){
          $firstFrame = $serial
          $firstFile = $_.name
        }
        if ($lastframe -lt $serial){
          $lastframe = $serial
          $lastFile = $_.name
        }
        write-host "checking frame #$serial, first frame $firstFrame - $firstFile, last frame $lastframe - $lastFile"
        #wind back the cursor position so it doesn't scroll;
        [Console]::SetCursorPosition($Host.UI.RawUI.CursorPosition.X, $Host.UI.RawUI.CursorPosition.Y-1)
        if ($_.extension -eq ".png"){ #only check png files
          $badFile = ((pngcheck.exe $_.fullname 2>&1) -match "Error");
          if ($badFile){
            # write-host "$_ is dodgy" -ForegroundColor Red;
            if ($removeDodgyPngs){ Remove-Item $_.fullname; 
              if($?) {$removedFrameCount++}
            }
            $badFiles += @{serial = $serial; fileName = $_.name};
          }
        }
      }
      
    }
  }
  $NumFrames = $lastframe - $firstFrame
  write-host "$numFrames frames, first frame $firstFile, last frame $lastFile";
  if ($badfiles.length -gt 0){
    $outputStr = ""
    Write-Host ("{0} bad frames, {1} removed" -f $badfiles.length, $removedFrameCount)
    Write-Host " bad Files:"
    for ($i =0; $i -lt $badfiles.length; $i++){
      $outputStr += $badfiles[$i].fileName;
      if ($i -lt $badfiles.length-1 -and $badfiles[$i+1].serial -eq $badfiles[$i].serial+1){
        $outputStr += " - ";
        while ($i -lt $badfiles.length-2 -and $badfiles[$i+1].serial -eq $badfiles[$i].serial+1){
          $i++
        }
      } else {
        $outputStr += "`n"
      }
    }
    Write-Host $outputStr -ForegroundColor Red
  }
}

function test-PngSequence{
  Param ($searchFolder = ".\",
  [int]$StartFrame = 0,
  [int]$digits = 0,
  [switch]$removeDodgyPngs
  )
  $i = $StartFrame;
  $firstFrame = $null;
  if (! $digits){
    Get-ChildItem (get-item $searchFolder) | Where-Object {
      $_.name -match "([0-9]+)\.[A-z]+$"
      # break
    }| select-object -first 1
    $digits = $Matches[1].length;
  }
  Write-Host $digits
  Get-ChildItem (get-item $searchFolder) |ForEach-Object{
    while (! ( $_.name -match ("{0:d$digits}{1}" -f $i, $_.extension))) {
      write-host "missing frame $i" -ForegroundColor Red;
      $i++;
    };
    if ($null -eq $firstFrame){$firstframe = $i}
    Write-Host "checking $i";
    #wind back the cursor position so it doesn't scroll;
    [Console]::SetCursorPosition($Host.UI.RawUI.CursorPosition.X, $Host.UI.RawUI.CursorPosition.Y-1);
    if ($_.extension -eq ".png"){ #only check png files
      $badFile = ((pngcheck.exe $_.fullname 2>&1) -match "Error");
      if ($badFile){
        write-host "$_ is dodgy" -ForegroundColor Red;
        if ($removeDodgyPngs){ Remove-Item $_.fullname; }
      }
    }
    $i++;
  };
  Write-Host "first frame $firstFrame";
  Write-Host ("last frame {0}" -f ($i - 1));
}

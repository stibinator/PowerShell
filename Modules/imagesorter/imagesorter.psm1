ls -r |?{ $_.Extension -match "\.jpe*g"}|%{
  #echo $_.name

  $x = (exiftool $_.fullname -createdate);
  #echo $x
  if ($x -match "[^0-9]*(\d{4}):(\d{2}):(\d{2}) (\d{2}):(\d{2}):(\d{2})"){
    $newname = ("{0}-{1}-{2}_{3}-{4}-{5}" -f $matches[1], $matches[2], $matches[3], $matches[4], $matches[5], $matches[6])
    $ydir = (Join-Path "C:\Users\sdixon.MV\OneDrive - Museum Victoria\sdixon\sorted\" $matches[1])
    mkdir $ydir -ErrorAction SilentlyContinue
    $mdir = (Join-Path $ydir $matches[2]) # should be like 2011\01
    mkdir $mdir -ErrorAction SilentlyContinue
    $newpath =(Join-Path  $mdir ($newname + ".jpg"))
    #Write-Host ("moving to {0}" -f $newpath) -ForegroundColor "Green"
    $suffix = 1
    while (Test-Path $newpath) {
      Write-Host ("path exists {0}" -f $newpath) -ForegroundColor "Red"
      $newpath = (Join-Path $mdir ($newname + "_" + $suffix + ".jpg"))
      $suffix += 1
    }
    mv $_.fullname $newpath
  }
  else {
    write-host ("no exif data for {0} " -f $_.name) -BackgroundColor "darkRed"
    mv $_.FullName "..\unsorted\"
  }
}

function Convert-YTSRT-to-CSV{
  #Requires -version 2.0
  [CmdletBinding()]

  param(
    [Parameter(Position=0, Mandatory=$True,ValueFromPipeLine=$True)]
    $inputFile,
    [Parameter(Position=1, Mandatory=$False)]
    $outFile,
    [switch] $DoubleTimeCodeField,
    [switch] $NoDialogNumber,
    [decimal] $framerate = 25
  );
  #handle being passed a path or a file

  $inputFile = Get-Item $inputFile -ErrorAction SilentlyContinue
  if (! $inputFile){
    throw "You need to specify a valid input file"
  }

  #create an outfile path if not given one
  if (! $outfile){
    $outFile = (join-path $inputFile.Directory $inputFile.name.Replace(".srt", ".csv"));
    Write-Output ("{0} -> {1}" -f $inputFile, $outFile)
    if (test-path $outFile){
      if ($outfile -eq $inputFile.fullname){
        throw "Can't overwrite the original file"
      }
      if (! $OverWriteWithoutAsking){
        $resp = (read-host "over-write existing file? [Y]n")
        $overWrite = (($resp -match "^Y") -or ($resp.length -eq 0))
      }
      if ($overWrite -or $OverWriteWithoutAsking){
        remove-item $outfile
      } else {
        break
      }
    }
  }
  Write-Output ("Writing to {0}" -f $outFile);
  $frameDuration = (1000 / $framerate)
  Set-content $outfile "";
  #read the srt file
  Get-Content $inputFile|ForEach-Object{

    #line number if required
    if ($_ -match "^(\d{1,3})$"){
      if (! $NoDialogNumber){
        $n=""+$Matches[1] + ","
      } else {
        $n = ""
      }
    }
    #timecode
    elseif ($_ -match "^(\d{2}:\d{2}:\d{2}),(\d{3}) --> (\d{2}:\d{2}:\d{2}),(\d{3})$"){
      #frame needs to be formatted
      $infr = [math]::round([decimal]($Matches[2] / $frameDuration));
      if ($DoubleTimeCodeField){
        $outfr = [math]::round([decimal]($Matches[4] / $frameDuration));
        $t = ("{0}:{1:00},{2}:{3:00}," -f $matches[1], [decimal] $infr, $Matches[3], $outfr);
      } else {
        $t = ("{0}:{1:00}," -f $matches[1], [decimal] $infr)
      }
    }
    #text payload - ignore empty lines
    elseif (! ($_ -match "^$")){
      $text = $n + $t + $_
      Add-Content $outFile $text
    }
  }
}

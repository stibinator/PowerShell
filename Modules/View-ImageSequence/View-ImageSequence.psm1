function View-ImageSequence{
  param(
    [Parameter(Position=0,ValueFromPipeLine=$True)]$fileOrDir,
    [int]$fps = 25,
    [switch]$Alpha,
    [switch]$noLoop
  );
  write-host "View Image Sequence v1.2" -foregroundColor "Yellow"
  #no file or folder given, so use curren folder
  if (! ($fileOrDir)){
    $fileOrDir = Get-location;
  }
  #turn string into FS Object
  $fileOrDir = get-item $fileOrDir;
  #given a folder, so look inside it
  if ($fileOrDir.PSIsContainer){
    $seqFolder = $fileOrDir.fullname
    write-host ("looking for image sequence in folder {0}" -f $fileOrDir.name )
    #find first file with a number at the end of the name
    $fileOrDir =@( get-childItem $fileOrDir|?{$_.name.replace($_.extension, "") -match "[0-9]$"})[0];
    write-host ("found image sequence file {0}" -f $fileOrDir.name ) -foregroundColor "Green"
  } else {
    #given a file, so find its containing directory
    $seqFolder = ($fileOrDir.Directory).FullName;
  }
  #find the non-numeric part of the name and replace it with an asterisk
  if($fileOrDir.name -match "([^\d]+)"){
    $basename = ("{0}*{1}" -f $Matches[1], $fileOrDir.Extension)
  }
  #show alpha is user wants it
  if ($Alpha){
    $doAlpha = "yes"
  }else{
    $doAlpha = "blend"
  }
  #loop by default, but user can specify one playback only
  if ($noLoop){
    $loop = "no"
  }else{
    $loop = "yes"
  }
  write-host ('mpv.exe "mf://{0}" --mf-fps {1} --loop-file "{2}"  --alpha="{3}"' -f (join-path $seqFolder $basename), $fps, $loop, $doAlpha);
  #run mpv
  start-process 'mpv.exe' -argumentList (('"mf://{0}" --mf-fps {1} --loop-file "{2}"  --alpha="{3}"' -f (join-path $seqFolder $basename), $fps, $loop, $doAlpha))
}

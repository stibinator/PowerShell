function imageSeqView{
  param([Parameter(Position=0, Mandatory=$True,ValueFromPipeLine=$True)]$firstFile);
  $actualFile = (get-item $firstFile);
  if($actualFile -match "([^\d]+)"){
    $basename = ("{0}*{1}" -f $Matches[1], $actualFile.Extension)
  }
  & mpv.exe ("mf://{0}" -f $basename) -mf-fps 25 --loop-file yes
}

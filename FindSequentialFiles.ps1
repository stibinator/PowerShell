function get-sequentialAwareFileList {
  param (
  # Directory to search
  [Parameter(Mandatory)]
  [String] $dir
  )
  
  $f = @();
  $n=0;
  Get-ChildItem $dir |ForEach-Object{
    if ($f.length -eq 0){
      $f += $_.name
    } else {
      if ($_.name -match (("([0-9]+{0})" -f $_.extension))){
        $basename = $_.name.replace($Matches[1], "");
        if ($f[-1].startsWith($basename)){
          $n++
          $f[-1] = $f[-1] -replace ($_.extension + "( \+ [0-9]+ more)*"), ""
          $f[-1] = $f[-1] + ($_.Extension + " + $n more")
        } else {
          $f+=$_.name
        }
      }
    }
  }
  return $f
}


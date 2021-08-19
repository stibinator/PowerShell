function chocoList {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [String]
    $searchTerm
  )
  choco list $searchTerm 2>&1 | ForEach-Object {
    if ($_ -match "\w+") {
      write-host $Matches[0] -ForegroundColor Cyan -NoNewline
      $summ = choco info $Matches[0] | Select-String -Pattern "Summary"
      if ($summ) {
        ([string]$summ).replace("Summary: ", "")
      }
      else {
        " No desc."
      }
    }
  }
}
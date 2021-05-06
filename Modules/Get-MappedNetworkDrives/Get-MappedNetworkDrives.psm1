function get-mappedNetworkDrives{
    param (# write to console   
    [string]$listFile = "~\appdata\local\mappedDrives.xml",
    [switch]$writeToConsole
    )
    $drives = Get-PSDrive -PSProvider FileSystem |
    Select-Object Name, DisplayRoot |
    Where-Object {$null -ne $_.DisplayRoot}
    if ($writeToConsole){
        $drives|format-table
    }
    Export-Clixml -Path $listFile -InputObject $drives
}

function set-mappedDrivesFromList{
    param (
        [string]$listFile = "~\appdata\local\mappedDrives.xml"
    )
    $mappedDrives = Import-Clixml $listFile
    $mountedDrives = "";
    for ($i=0; $i -lt $mappedDrives.names.length; $i++){
      $d = $mappedDrives[$i];
      $n = $d.name + ":";
      $r = $d.DisplayRoot;
      #mount each drive
      if (! (test-Path $n)){
          net use "$n" "$r" >$null 2>$null;
          $mountedDrives += " " + $n;
      }
    }
    if ($mountedDrives -ne ""){
        Write-Host -ForegroundColor Yellow ("mounted " + $mountedDrives)
    }
  }
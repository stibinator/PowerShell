    function Restore-Profile {
    @($Profile.AllUsersAllHosts,
    $Profile.AllUsersCurrentHost,
    $Profile.CurrentUserAllHosts,
    $Profile.CurrentUserCurrentHost
    ) | ForEach-Object {
      if(Test-Path $_){
        Write-Host "Running $_" -foregroundcolor Magenta
        . $_
      }
    }
  }
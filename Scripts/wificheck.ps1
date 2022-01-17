Write-Host "checking the wifi"
$t = test-connection '8.8.8.8'

$connected = $false;
for($i = 0; $i -lt $t.Status.Length; $i++){
    if ($t.Status[$i] -eq 'Success'){
        $connected = $true
    }
}

if ($connected){
    Write-Host "all good" -ForegroundColor "Green"
    sleep 2
} else {
    Write-Host "restarting the network adaptor" -ForegroundColor "Red"
    Restart-NetAdapter -name "wi-fi"
}
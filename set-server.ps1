import-module MySQL
$password = ConvertTo-SecureString "Hwv2KjKbH5ZK8yPG" -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ("webuser", $password)
$Global:MySQLConnection = Connect-MySqlServer -ComputerName "production.mv.vic.gov.au" -Credential $cred 
$drvs = @(
    @{"path" = "V:\"; "URI" = "//production/ProdStore/VideoDB/" },
    @{"path" = "W:\"; "URI" = "//mv/Shares/Archives/Media Production archive/Video Production Archive-database" },
    @{"path" = "\\production\ProdStoreTempArchive"; "URI" = "//production/ProdStoreTempArchive" }
)
function set-mediaserver {
    param (
        [string]$folder,
        [string]$URI
    )
    Write-Host $folder -ForegroundColor Blue

    if ((Get-Item($folder)).name -match "MV([0-9]+)") {
        $MVVDBNumber = $Matches[1];
        $query = ("SELECT tapedb.tapedb WHERE tape_id={0};" -f $MVVDBNumber);
        
            Write-Host $query -ForegroundColor Green; 
            $go = (read-Host "Write to db? Y/n" );
        
        if ((! $ReviewEachQuery) -or $go.ToLower() -match "y") {
            $result = Invoke-MySqlQuery -Query $query;
        }
        Write-Host $result -ForegroundColor Yellow
    } else {
        Write-Host ("Folder name {0} is not in the database" -f $folder.name)
    }
}
$drvs | ForEach-Object {
    $p = $_.path;
    $u = $_.URI
    Write-Host $p -ForegroundColor Red
    Write-Host $u -ForegroundColor Green
    Get-ChildItem $p | ForEach-Object {
        set-mediaserver -folder $_ -uri $u
    }
}
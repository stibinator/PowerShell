function walk {                            
    param (
    [string] $d,
    [int] $c
    )  
    write-host $c                             
    $d =get-item $d                          
    Get-ChildItem $d|%{                      
        if ($_.PSIsContainer){
            Write-Host $_.fullname -ForegroundColor Red                   
            walk -d $_.fullname -c ($c+1)
        } else {                                 
            Write-Host $_.name -ForegroundColor Green -NoNewline
        }                                        
    }                                        
}                                        
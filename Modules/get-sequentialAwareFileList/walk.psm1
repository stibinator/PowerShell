function walk {                            
    param ($d)                               
    $d =get-item $d                          
    Get-ChildItem $d|%{                      
        if ($_.PSIsContainer){                   
            walk $_.fullname                          
        } else {                                 
            Write-Host $_.name -ForegroundColor Green
        }                                        
    }                                        
}                                        
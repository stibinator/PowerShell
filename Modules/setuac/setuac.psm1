$Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" 
$ConsentPromptBehaviorAdmin_Name = "ConsentPromptBehaviorAdmin" 
$PromptOnSecureDesktop_Name = "PromptOnSecureDesktop" 

Function Set-RegistryValue($key, $name, $value, $type="Dword") {  
    If ((Test-Path -Path $key) -Eq $false) { New-Item -ItemType Directory -Path $key | Out-Null }  
    Set-ItemProperty -Path $key -Name $name -Value $value -Type $type  
}  
Function Get-RegistryValue($key, $value) {  
    (Get-ItemProperty $key $value).$value  
}  

Function Get-UACLevel(){ 
    $ConsentPromptBehaviorAdmin_Value = Get-RegistryValue $Key $ConsentPromptBehaviorAdmin_Name 
    $PromptOnSecureDesktop_Value = Get-RegistryValue $Key $PromptOnSecureDesktop_Name 
    If($ConsentPromptBehaviorAdmin_Value -Eq 0 -And $PromptOnSecureDesktop_Value -Eq 0){ 
        "Never notify" 
    } 
    ElseIf($ConsentPromptBehaviorAdmin_Value -Eq 5 -And $PromptOnSecureDesktop_Value -Eq 0){ 
        "notify me only when apps try to make changes to my computer(do not dim my desktop)" 
    } 
    ElseIf($ConsentPromptBehaviorAdmin_Value -Eq 5 -And $PromptOnSecureDesktop_Value -Eq 1){ 
        "notify me only when apps try to make changes to my computer(default)" 
    } 
    ElseIf($ConsentPromptBehaviorAdmin_Value -Eq 2 -And $PromptOnSecureDesktop_Value -Eq 1){ 
        "Always notify" 
    } 
    Else{ 
        "Unknown" 
    } 
} 

Function Set-UACLevel() { 
    Param([int]$Level= 2) 

    If($Level -In 0, 1, 2, 3) { 
        $ConsentPromptBehaviorAdmin_Value = 5 
        $PromptOnSecureDesktop_Value = 1 
        Switch ($Level)  
        {  
            0 { 
                $ConsentPromptBehaviorAdmin_Value = 0  
                $PromptOnSecureDesktop_Value = 0 
            }  
            1 { 
                $ConsentPromptBehaviorAdmin_Value = 5  
                $PromptOnSecureDesktop_Value = 0 
            }  
            2 { 
                $ConsentPromptBehaviorAdmin_Value = 5  
                $PromptOnSecureDesktop_Value = 1 
            }  
            3 { 
                $ConsentPromptBehaviorAdmin_Value = 2  
                $PromptOnSecureDesktop_Value = 1 
            }  
        } 
        Set-RegistryValue -Key $Key -Name $ConsentPromptBehaviorAdmin_Name -Value $ConsentPromptBehaviorAdmin_Value 
        Set-RegistryValue -Key $Key -Name $PromptOnSecureDesktop_Name -Value $PromptOnSecureDesktop_Value 
        
        Get-UACLevel 
    } 
    Else{ 
        "No supported level" 
    } 
    
} 

Export-ModuleMember -Function Get-UACLevel 
Export-ModuleMember -Function Set-UACLevel

# Ascii art fun
get-content (join-path $env:APPDATA "backshitup.log")

Write-host "`n  /BBBBBBB   /AAAAAA   /CCCCCC  /KK   /KK/IIIIII /NN   /NN  /''`n | BB__  BB /AA__  AA /CC__  CC| KK  /KK/_  II_/| NNN | NN | ''`n | BB  \ BB| AA  \ AA| CC  \__/| KK /KK/  | II  | NNNN| NN  \ '`n | BBBBBBB | AAAAAAAA| CC      | KKKKk/   | II  | NN NN NN  |_/`n | BB__  BB| AA__  AA| CC      | KK  KK   | II  | NN  NNNN`n | BB  \ BB| AA  | AA| CC    CC| KK\  KK  | II  | NN\  NNN`n | BBBBBBB/| AA  | AA|  CCCCCC/| KK \  KK/IIIIII| NN \  NN`n |_______/ |__/  |__/ \______/ |__/  \__/______/|__/  \__/`n`n`n  /SSSSSS  /HH   /HH /IIIIII /TTTTTTTT       /UU   /UU /PPPPPPP  /!! `n /SS__  SS| HH  | HH|_  II_/|__  TT__/      | UU  | UU| PP__  PP| !! `n |SS  \__/| HH  | HH  | II     | TT         | UU  | UU| PP  \ PP| !! `n | SSSSSS | HHHHHHHH  | II     | TT         | UU  | UU| PPPPPPP/| !! `n \____  SS| HH__  HH  | II     | TT         | UU  | UU| PP____/ |__/ `n /SS  \ SS| HH  | HH  | II     | TT         | UU  | UU| PP           `n | SSSSSS/| HH  | HH /IIIIII   | TT         |  UUUUUU/| PP       /!! `n \______/ |__/  |__/|______/   |__/          \______/ |__/      |__/ `n " -foregroundColor "yellow"

#--------------------------------------------------------------------------------
function DismountNetworkDrive {
	param(
		[string] $Drive
	)
	Write-Host "Dismounting Network Drive: $Drive..." -foregroundColor "yellow"
	$objNet = New-Object -ComObject "WScript.Network"
	$objNet.RemoveNetworkDrive($Drive, $true)
	if ($?){
		Write-Host "Dismounted Network Drive" -foregroundColor "yellow"
	} else {
		if ($Error[0].toString() -Match "This network connection does not exist."){
			Write-host "It's all good - network drive already disconnected" -foregroundColor "green"
		} else {
			read-Host ("There was an error:`n{0}`nReturn to continue." -f $Error[0]) -foregroundColor "Red"
		}
	}
}
#--------------------------------------------------------------------------------

# commented out the next two lines because it's more reliable to use UNC
#Import-Module "networkdrives" #easily mount/unmount mapped drives
#MountNetworkDrive "\\mmfs1\users\stib" "\\mmfs1\users\stib"  #2>&1 > "c:\Users\stib\backuplog.txt"

# robocopy options
# /s  recurSe
# /xo eXclude Older
# /xj eXclude Junctions (prevents infinite loops)
# /MT40 40 Threads
# /nfl /ndl /njh don't log File List, Dir List or Job Header

$f = $host.ui.RawUI.ForegroundColor
$host.ui.RawUI.ForegroundColor = "cyan"
$myDocs = [environment]::getfolderpath("MyDocuments");
$projectsFolder =  join-path $myDocs "current work";
write-host "backing up work projects folder: $projectsFolder"
$projectsBUpFolder = "J:\backup" 	#'\\mmfs1\users\stib\My Documents\work'
$pwshBUpFolder = "J:\pwshBUp" 		#"\\mmfs1\users\stib\My Documents\WindowsPowerShell"
$DevBUp = "J:\DevBUp" 				#'\\mmfs1\users\stib\My Documents\development'
& robocopy.exe "$projectsFolder" "$projectsBUpFolder" /s /xo /xj /MT40 /nfl /ndl /njh 
$host.ui.RawUI.ForegroundColor = "Magenta"

$pShellFolder =  join-path $myDocs "WindowsPowerShell";
write-host "backing up powershell folder: $pShellFolder"
& robocopy.exe "$pShellFolder" "$pwshBUpFolder" /s /xo /xj /MT40 /nfl /ndl /njh 

$devFolder =  join-path $myDocs "development";
$host.ui.RawUI.ForegroundColor = "DarkRed"
write-host "backing up development folder: $devFolder"
& robocopy.exe "$devFolder" "$DevBUp" /s /xo /xj /MT40 /nfl /ndl /njh 

$host.ui.RawUI.ForegroundColor = $f
#and again, using the UNC path
# DismountNetworkDrive "H:" 2>&1 > $null
set-content (join-path $env:APPDATA "backshitup.log")("last back up {0}" -f (Get-Date)) 
Start-Sleep 3

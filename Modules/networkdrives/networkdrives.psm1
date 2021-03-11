#--------------------------------------------------------------------------------
function MountNetworkDrive {
param(
	[string] $Drive,
	[string] $NetworkPath
)
	Write-Host "-> MountNetworkDrive"
	$objNet = New-Object -ComObject "WScript.Network"
	$objNet.MapNetworkDrive(($Drive), $NetworkPath)
	Start-Sleep -Milliseconds 500
	Write-Host (Get-PSDrive) # Do not remove, is't workaround for Join-Path
	Write-Host "<- MountNetworkDrive"
}
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
function DismountNetworkDrive {
param(
	[string] $Drive
)
	Write-Host "-> DismountNetworkDrive"
	$objNet = New-Object -ComObject "WScript.Network"
	Write-Host "Removing $Drive ..."
	$objNet.RemoveNetworkDrive($Drive, $true)
	Write-Host "<- DismountNetworkDrive"
}
#--------------------------------------------------------------------------------

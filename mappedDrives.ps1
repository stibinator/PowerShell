Get-PSDrive -PSProvider FileSystem |
Select-Object Name, DisplayRoot |
Where-Object {$_.DisplayRoot -ne $null}|
Export-Clixml "~\appdata\local\mappedDrives.xml"
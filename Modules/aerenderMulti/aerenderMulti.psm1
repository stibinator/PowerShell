$tempFileWinPath = "$HOME\Appdata\local\temp\rqcount.txt"

function Invoke-SelectFileDialog
{
	param([string]$Title,[string]$Directory,[string]$Filter="All Files (*.*)|*.*")
	powershell -NoProfile -ExecutionPolicy Bypass -Command { #for compatibility with powershell core
		$result = $false
		[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
		$objForm = New-Object System.Windows.Forms.OpenFileDialog
		$objForm.InitialDirectory = $Directory
		$objForm.Filter = $Filter
		$objForm.Title = $Title
		$Show = $objForm.ShowDialog()
		If ($Show -eq "OK")
		{
			$result = $objForm.FileName
		}
		Else
		{
			write-host ("Operation cancelled by user.")
		}
		return $result
	}
}


# returns human readable saved date for the project
function get-SaveDate
{
	param($projFile)
	$d=(Get-Date)
	$dif = $d - $projFile.lastWriteTime
	if ( $dif.days -gt 0){
		if ($dif.days -gt 1){$s ="s"} else {$s = ""}
		$saved = ("{0} day{1} ago" -f $dif.days, $s )
	} elseif ($dif.Hours -gt 0) {
		if ($dif.hours -gt 1){$s ="s"} else {$s = ""}
		$saved = ("{0} hour{1} ago" -f $dif.hours, $s )
	} elseif ($dif.minutes -gt 0){
		if ($dif.minutes -gt 1){$s ="s"} else {$s = ""}
		$saved = ("{0} minute{1} ago" -f $dif.minutes, $s )
	} elseif (($dif.seconds + $dif.milliseconds) -gt 0){
		$saved = ( "just now")
	} else {
		$saved = "In the future? WTF!?"
	}
	return $saved
}

function test-isThereANewerVersion
{
	param($projFile)
	$olderVersion = $false
	if ($projFile.name -match "([0-9]+).aep"){
		$suffix = $Matches[0] #should be 123.aep
		$vers = $Matches[1] #should be 123
		$basename = $projFile.name.replace($suffix, "")
		Get-ChildItem $projFile.directory|ForEach-Object{
			if ($_.name -match (($basename + "([0-9]+)\.aep$"))){
				$otherVers = $Matches[1] #should be 122
				if (([int]$otherVers) -gt ([int]$vers)){ 
					$olderVersion = $_
					Write-Host "older version: $olderVersion"
					$vers = $otherVers
				}
			}
		}
		return $olderVersion
	}
}

function  get-AERenderExecutable {
	$adobeFolder = Join-Path $Env:Programfiles "Adobe" 
	$versions = Get-ChildItem $adobeFolder|Where-Object {$_.name -match "Adobe After Effects"}
	$latestVersion = ($versions |Sort-Object)[-1]
	return (get-item (join-path $latestVersion 'support files' 'aerender.exe')).fullname
}
function  get-AEExecutable {
	$adobeFolder = Join-Path $Env:Programfiles "Adobe" 
	$versions = Get-ChildItem $adobeFolder|Where-Object {$_.name -match "Adobe After Effects"}
	$latestVersion = ($versions |Sort-Object)[-1]
	return (get-item (join-path $latestVersion 'support files' 'AfterFX.exe')).fullname
}

function Get-RQCount($projFile){
	$w = get-foreGroundWindow
	$AfterFX =  get-AEExecutable
	Remove-Item $tempFileWinPath -ErrorAction silentlycontinue
	# can't script AE when aerender is running
	if (! (get-process "aerender" -ErrorAction SilentlyContinue)){
		$projURI = $projFile.fullName.replace('\', '/').replace('C:', '/c').replace(' ','%20')
		$tempFile = '~/Appdata/Local/Temp/rqcount.txt'
		
		$AEscript = ("
		if (! app.project.file.fsName === '" + $projFile.fullName +  "' ){
			var renderProj=new File('" + $projURI + "');
			app.open(renderProj);
		};
		var tempFile = new File('" + $tempFile + "');
		tempFile.open('w');
		for (var i=1; i <= app.project.renderQueue.numItems; i++){
			if (app.project.renderQueue.item(i).status == RQItemStatus.QUEUED){
				tempFile.write('' + i + ',' + app.project.renderQueue.item(i).comp.name + '\n');
			}
		}
		tempFile.close();");
		& $AfterFX -noui -so -s $AEscript;
		# write-host ("waiting for After Effects to load the project")
		$waitCount = 0
		while((! (test-path $tempFileWinPath -ErrorAction SilentlyContinue)) -and ($waitCount -lt 90)){
			Start-Sleep 1;
			# write-host (".") -nonewline;
			$waitCount++;
		}
	} else {
		write-host "can't count the queue when aerender instances are running" -foregroundColor "Magenta"
	}
	set-foreGroundWindow $w #grab focus back
}

function Invoke-AerenderMulti
{
	param(
	[string]$project,
	[string]$statusFile,
	[int]$instances=8,
	[int]$pauseBetweenInstances=5,
	[switch]$noConfirm,
	[switch]$waitForPreviousRender,
	[switch]$addToQueue,
	[string]$shutDownAfterwards="",
	[switch]$noNewWindow,
	[switch]$waitUntilAllRendersAreDoneBeforeQuitting,
	[switch]$runAERenderAtNormalPriority,
	[switch]$useLastProjectFile,
	[string]$AERenderExecutable
	)
	$settingsFile = join-path $env:APPDATA "pureandapplied" "invoke-aerender-lastproj.txt"
	write-host ("Invoke-AerenderMulti runs several multi-machine renderers in parallel`nInstances can be started and stopped while rendering.`nQueued comps must be saved as multi-machine renders for it to work`nUse Invoke-aerendersingle for single machine comps") -foregroundColor Yellow
	if ((! $AERenderExecutable) -or (! (test-path $AERenderExecutable))){
		$AERenderExecutable = get-AERenderExecutable
	}
	if ($AERenderExecutable)
	{
		$okToGo = "y";
		$userIsAdmin = (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator));
		if ( $shutDownAfterwards ){
			if (! $userIsAdmin){
				# user is not admin - can't shut down\
				write-host ("`nWARNING - user is not admin - can't shutdown or sleep`n") -foregroundcolor "red";
				$shutDownAfterwards = "";
				$okToGo = (Read-Host ("continue anyway?`n[Y,n]")).toLower()
			}
		}
		if (! ($okToGo -match "n")){
			if (! $project){
				if ($useLastProjectFile){
					$project = Get-Content $settingsFile
				} else {
					$project = (Invoke-SelectFileDialog -title "choose a project"  -Filter "After Effects Projects files *.aep|*.aep")
				}
			}
			if ($project){
				set-content -path $settingsFile -value $project.ToString();
				$projFile = get-ChildItem $project #turns string path (or file object) into file object
				
				$newervers = test-isThereANewerVersion($projFile);
				if ($newervers){
					if ($newervers.lastWriteTime -gt $projFile.lastWriteTime){
						$versMsg = "newer version"
						$colour = "red"
					} else {
						$versMsg = "version with higher serial number"
						$colour = "DarkYellow"
					}
					write-host ("*** There appears to be a {0}! ***" -f $versMsg) -foregroundColor $colour
					if (! ($noConfirm) ){
						$useNewer = (Read-Host ("[ 1 ] use {0,-25} - saved {2}`n[(2)] use {1,-25} - saved {3}" -f $projFile.name, $newervers.name, $projFile.lastWriteTime, $newervers.lastWriteTime))
						if (!($useNewer -eq 1)){$projFile = $newervers}
					}
				}
				$saved = get-SaveDate($projFile);
				#report to thew user what's going on
				$divider = "`n" + ("-" * (Get-Host).ui.rawui.windowsize.width) + "`n"; # trick to make a row of dashes the width of the window
				write-host ($divider) -foregroundColor Yellow
				write-host ((Get-Date)) -foregroundColor Yellow
				write-host ("`n{0,-24}" -f "Rendering project: ") -foregroundColor Cyan -nonewline
				write-host $projFile.name -foregroundColor White
				write-host ("`{0,-24}" -f "from folder:") -foregroundColor Cyan -nonewline
				write-host $projFile.directory.fullname -foregroundColor White
				# write-host ($divider) -foregroundColor Yellow
				if ($saved -eq "just now"){
					write-host ("{0,-24}" -f "last saved:") -foregroundColor Cyan -nonewline
					write-host $saved -foregroundColor Green
				} elseif ($saved -match "minutes ago"){
					write-host ("{0,-24}" -f "last saved:") -foregroundColor Cyan -nonewline
					write-host $saved -foregroundColor DarkGreen
				} elseif ($saved -match "WTF"){
					write-host ("{0,-24}" -f "last saved:") -foregroundColor Cyan -nonewline
					write-host $saved -foregroundColor Red 
				} else {
					write-host ("{0,-24}" -f "last saved:") -foregroundColor Cyan -nonewline
					write-host $saved -foregroundColor white
				} 
				write-host $divider -foregroundColor Yellow
				write-host ("Using [ {0} ] instances of AERender" -f $instances ) -foregroundColor Cyan
				write-host "`nAerender executable is " -foregroundColor Cyan -NoNewline
				Write-Host $AERenderExecutable
				if ($waitUntilAllRendersAreDoneBeforeQuitting){
					write-host ("`nWaiting for the render to finish") -foregroundColor DarkYellow
				};
				if ($shutDownAfterwards -match "sl"){
					write-host ("`nthen sleeping") -foregroundColor DarkYellow
				}
				if ($shutDownAfterwards -match "sh"){
					write-host ("`nthen shutting down") -foregroundColor DarkYellow
				}
				write-host ("`n" + $divider) -foregroundColor Yellow
				
				
				if ($StatusFile){add-content $statusfile  (Get-Date) }
				if (! ($noConfirm) ){
					Write-Host ("Type the number of instances, 'n' to cancel, `nor [return] to use default: [ {0} ]" -F $instances) -ForegroundColor DarkYellow
					$goAhead = (Read-Host).toLower()
				}	else {
					$goAhead = $instances
				}
				if ($waitForPreviousRender){
					'waiting for previous render to finish'
					psshutdown -a 2>&1 > $null; #if previous render ends with shutdown, cancel it. Only works in admin shells
					while (get-process -ProcessName "aerender*"){"waiting"; Start-Sleep 300};
				}
				#good to go
				if (! (($goAhead) -eq "n")){
					if (($goAhead -as [int]) -gt 0){ #user typed a number
						$instances = ($goAhead -as [int]);
						("starting {0} instances" -f $instances);
					}
					$mydocuments = [environment]::getfolderpath("mydocuments")
					$ROTempFile = Join-Path $mydocuments "ae_render_only_node.txt"
					Set-Content $ROTempFile ""  -ErrorAction SilentlyContinue
					for ($i = 0 ; $i -lt $instances; $i++ ){
						if ($noNewWindow){
							
							Start-Process $AERenderExecutable -ArgumentList '-project', ('"{0}"' -f $projFile.fullname) -noNewWindow
						} else {
							Start-Process $AERenderExecutable -ArgumentList '-project', ('"{0}"' -f $projFile.fullName)
						}
						# running at lower priority means you can do stuff in the foreground to some extent.
						if (! ($runAERenderAtNormalPriority)){Get-Process "aerender" -ErrorAction silentlycontinue|ForEach-Object{$_.PriorityClass = "BelowNormal"}};
						Start-Sleep $pauseBetweenInstances ;
						("starting node {0,-3} - {1}" -F $i, (get-date));
						if ($StatusFile){add-content $statusfile  ("starting node {0,-3} - {1}" -F $i, (get-date)) }
					}
					if (($shutDownAfterwards -match "s[hl]") -or $waitUntilAllRendersAreDoneBeforeQuitting){
						"waiting for render to end"
						while (get-process -processname "aerender" -ErrorAction silentlycontinue){
							write-host -nonewline "." ;
							Start-Sleep 60
						}
					}
					if ($shutDownAfterwards -match "sl"){
						("finished rendering {0} at {1}" -F $projFile.name, (get-date));
						if ($StatusFile){add-content $statusfile  ("finished rendering {0} at {1}" -F $projFile.name, (get-date)) }
						& psshutdown.exe -d -t 30
					}
					elseif ($shutDownAfterwards -match "sh"){
						("finished rendering {0} at {1}" -F $projFile.name, (get-date));
						if ($StatusFile){add-content $statusfile  ("finished rendering {0} at {1}" -F $projFile.name, (get-date)) }
						& psshutdown.exe -k -t 30
					}
					remove-item $ROTempFile -ErrorAction SilentlyContinue
				} else {
					"user cancelled"
					if ($StatusFile){add-content $statusfile  ("User cancelled") }
				}
			}
		}
	}
}

function Invoke-AerenderSingle
# used for parallel renders of single machine comps
{
	param(
	[string]$project,
	[string]$statusFile,
	[int]$maxInstances=8,
	[int]$firstQIndex=1,
	[int]$lastQIndex=0,
	[switch]$noConfirm,
	[switch]$waitForPreviousRender,
	[switch]$addToQueue,
	[string]$shutDownAfterwards="",
	[switch]$noNewWindow,
	[int]$pauseBetweenInstances=5,
	[switch]$waitUntilAllRendersAreDoneBeforeQuitting,
	[switch]$runAERenderAtNormalPriority,
	[switch]$countRenderQueue
	)
	write-host ("Invoke-AerenderSingle runs several single-machine renders in parallel, for multiple comps in the render queue`n") -foregroundColor Yellow
	$AERenderExecutable = get-AERenderExecutable
	if ($AERenderExecutable)
	{
		$okToGo = "y"
		$userIsAdmin = (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator));
		if ( $shutDownAfterwards ){
			if (! $userIsAdmin){
				# user is not admin - can't shut down\
				write-host ("`nWARNING - user is not admin - can't shutdown or sleep`n") -foregroundcolor "red";
				$shutDownAfterwards = "";
				$okToGo = (Read-Host ("continue anyway?`n[Y,n]")).toLower()
			}
		}
		if (! ($okToGo -match "n")){
			if (! $project){
				$project = (Invoke-SelectFileDialog -title "choose a project"  -Filter "After Effects Projects files *.aep|*.aep")
			}
			if ($project){
				$projFile = get-ChildItem $project #turns string path (or file object) into file object
				$saved = get-SaveDate($projFile);
				
				$newervers = test-isThereANewerVersion($projFile);
				if ($newervers){
					if ($newervers.lastWriteTime -gt $projFile.lastWriteTime){
						$versMsg = "newer version"
						$colour = "red"
					} else {
						$versMsg = "version with higher serial number"
						$colour = "darkyellow"
					}
					write-host ("*** There appears to be a {0}! ***" -f $versMsg) -foregroundColor $colour
					if (! ($noConfirm) ){
						$useNewer = (Read-Host ("[ 1 ] use {0,-25} - saved {1}`n[(2)] use {2,-25} - saved {3}" -f $projFile.name,  $projFile.lastWriteTime, $newervers.name, $newervers.lastWriteTime))
						if (!($useNewer -eq 1)){$projFile = $newervers}
					}
				}
				if ($countRenderQueue){
					write-host ("counting the render queue...")
					Get-RQCount($projFile);
					# use the measured  queue length if the user hasn't set one
					# -ErrorAction doesn't seem to work with import-csv. This works instead, I don't know why
					trap
					{
						continue
					}
					$rq = @(import-csv  $tempFileWinPath -header "num", "name" -ErrorAction SilentlyContinue)
				}
				if ($rq){
					write-host ("found {0} items in render queue:" -f $rq.length)
					$rq.ForEach({[PSCustomObject]$_}) | Format-Table -AutoSize
					if (!($lastQIndex)){$lastQIndex = $rq[-1].rqNum}
					if (!($firstQIndex)){$firstQIndex = $rq[0].rqNum}
				} else {
					if (!($lastQIndex)){$lastQIndex = 20}
					$rq = @();
					for ($q = $firstQIndex; $q -le $lastQIndex; $q++){
						$rq += @{"num" = $q; "name" = "unknown"};
					}
				}
				
				# write-host ("`$rqArr = {0}" -f $rqArr);
				$firstQIndex  = $rq[0].num;
				$lastQIndex = $rq[-1].num;
				# write-host ("FirstQIndex = {0}" -f $firstQIndex);
				# write-host ("lastQIndex = {0}" -f $lastQIndex);
				# if we're only rendering x comps, we don't need more than x instances
				if ($rq.length -lt $maxInstances){$maxInstances = $rq.length};
				#------------------report to the user what's going to happen------------------
				$f = $host.ui.RawUI.ForegroundColor
				$host.ui.RawUI.ForegroundColor = Yellow
				$divider = ("`n" + ("-" * (Get-Host).ui.rawui.windowsize.width) + "`n"); # trick to make a row of dashes the width of the window
				write-host ($divider);
				write-host (" " + (Get-Date));
				write-host ("`n Aerender executable is {0}" -f $AERenderExecutable );
				write-host ($divider);
				write-host (" {0,-24}" -f "Rendering project:") -nonewline;
				write-host ($projFile.name) -foregroundColor White;
				write-host ("`n {0,-24}{1}" -f "from folder:", $projFile.directory.fullname);
				if ($saved -eq "just now"){
					write-host (" {0,-24}" -f "last saved:") -nonewline;
					write-host $saved -foregroundColor Green;
				} else {
					write-host (" {0,-24}" -f "last saved:") -nonewline;
					write-host $saved -foregroundColor White;
				}
				write-host ($divider)
				write-host (" Starting at queue item ") -nonewline;
				write-host ("#" + $firstQIndex) -foregroundColor White
				write-host (" Finishing at queue item ") -nonewline;
				write-host ("#" + $lastQIndex) -foregroundColor White
				write-host ("`n Running at most [ ") -nonewline;
				write-host ($maxInstances ) -foregroundColor White -nonewline;
				write-host (" ] instances of AERender.exe at any time.");
				if ($waitUntilAllRendersAreDoneBeforeQuitting){
					write-host ("`n Waiting for the render to finish.");
				};
				if ($shutDownAfterwards -match "l"){
					write-host ("`n Then sleeping.");
				}
				if ($shutDownAfterwards -match "h"){
					write-host ("`n Then shutting down.");
				}
				write-host ($divider);
				$host.ui.RawUI.ForegroundColor = $f
				# -------------------End of report-----------------------
				
				if ($StatusFile){ add-content $statusfile  (Get-Date) }
				#confirm if necessary
				if (! ($noConfirm) ){
					write-host ("Ready to go. To start type in either:`n - the maximum number of instances,`n - 'n' to cancel, `n - or [return] to use: [ ") -nonewline;
					write-host ($maxInstances) -foregroundColor Yellow -nonewline;
					write-host (" ] instances at a time.");
					$goAhead = (Read-Host "max instances").toLower();
				}	else {
					$goAhead = $maxInstances;
				}
				#if waiting for a previous render to finish pause here till all aerender instances are done
				if ($waitForPreviousRender){
					'waiting for previous render to finish'
					psshutdown -a 2>&1 > $null; #if previous render ends with shutdown, cancel it. Only works in admin shells
					while (get-process -ProcessName "aerender*"){"waiting"; Start-Sleep 300};
				}
				if (! (($goAhead) -eq "n")){
					if (($goAhead -as [int]) -gt 0){ #user typed a number
						$maxInstances = ($goAhead -as [int]);
						("starting at most {0} instances" -f $maxInstances);
					}
					$instanceCount=(Get-Process "aerender" -ErrorAction SilentlyContinue|Measure-Object).count;
					For ($rqindex = 0; $rqindex -lt $rq.length; $rqindex++)
					{
						#check to see if there are available slots
						while ($instanceCount -ge $maxInstances) {
							#if not Start-Sleep for a bit
							Start-Sleep $pauseBetweenInstances;
							$instanceCount=(Get-Process "aerender" -ErrorAction SilentlyContinue|Measure-Object).count;
							write-host ("currently {0} instances        " -f $instanceCount) -nonewline;
							moveCursor 0 0 -relativeY;
						}
						#ok to go
						$msg = "starting node {0}, render queue item {1}: {2} - {3}" -F $rqindex, $rq[$rqindex].num, $rq[$rqindex].name, (get-date)
						write-host ($msg);
						if ($StatusFile){add-content $statusfile ($msg) }
						# echo '-project', ('"{0}"' -f $project), '-rqindex', $rqArr[$rqindex]
						if ($noNewWindow){
							Start-Process $AERenderExecutable -ArgumentList '-project', ('"{0}"' -f $projFile.fullName), '-rqindex', $rq[$rqindex].num -noNewWindow
						} else {
							Start-Process $AERenderExecutable -ArgumentList '-project', ('"{0}"' -f $projFile.fullName), '-rqindex', $rq[$rqindex].num
						}
						# running at lower priority means you can do stuff in the foreground to some extent.
						if (! ($runAERenderAtNormalPriority)){Get-Process "aerender" -ErrorAction silentlycontinue|ForEach-Object{$_.PriorityClass = "BelowNormal"}};
						Start-Sleep $pauseBetweenInstances ;
						$instanceCount=(Get-Process "aerender" -ErrorAction SilentlyContinue|Measure-Object).count;
					}
					if (($shutDownAfterwards -match "[hl]") -or $waitUntilAllRendersAreDoneBeforeQuitting){
						"waiting for render to end"
						while (get-process -processname "aerender" -ErrorAction silentlycontinue){
							write-host -nonewline "." ;
							Start-Sleep 60
						}
					}
					if ($shutDownAfterwards -match "l"){
						("finished rendering {0} at {1}" -F $projFile.name, (get-date));
						if ($StatusFile){add-content $statusfile  ("finished rendering {0} at {1}" -F $projFile.name, (get-date)) }
						& psshutdown.exe -d -t 30
					}
					elseif ($shutDownAfterwards -match "h"){
						("finished rendering {0} at {1}" -F $projFile.name, (get-date));
						if ($StatusFile){add-content $statusfile  ("finished rendering {0} at {1}" -F $projFile.name, (get-date)) }
						& psshutdown.exe -k -t 30
					}
				} else {
					"user cancelled"
					if ($StatusFile){add-content $statusfile  ("User cancelled") }
				}
			}
		}
	}
}

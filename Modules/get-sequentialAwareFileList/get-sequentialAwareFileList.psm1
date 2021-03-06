function get-sequentialAwareFileList {
    param (
    [string] $dir = ".\",
    [ValidateSet('JSON', 'flatText', 'indentedText', 'Object')]
    [string] $outputFormat = 'Object',
    [array] $includeFilesOfType = @(), 
    [array] $dontTruncateTheseFiles = @(),
    [array] $ignoreFilesMatching = @(),
    [bool] $dontRecurse = $false,
    [int] $verbose = 0,
    [string] $indent = "`t",
    [int] $level = 0,
    [int] $maxRecursionDepth = -1
    )
    
    if (($maxRecursionDepth -lt 0) -or ($level -le $maxRecursionDepth)){
        $d = get-item $dir
        $n=0;
        $f =@{"Directory" = $d.name}
        if ($verbose){
            Write-Host ("┣{1} {0}" -f $d.Name, ("━" * $level * 2) ) -ForegroundColor Blue # unicode FTW
        }
        $f.contents = @();
        if ($d){
            Get-ChildItem $d | Where-Object { !($_.Attributes -match "ReparsePoint") } |ForEach-Object{
                if ($verbose -gt 2){
                    if (-not $_.PSIsContainer){
                        Write-Host ("┃") -ForegroundColor Blue -NoNewline
                        Write-Host ("{1} {0}" -f $_.name, (" " * ($level + 1) * 2)) -ForegroundColor Green;
                    }
                }
                if ((! $dontRecurse) -and $_.PSIsContainer -and ($_.name -ne "")){
                     #return an object internally always, convert later
                    $subdir = get-sequentialAwareFileList `
                    -dir $_.FullName  `
                    -outputFormat 'Object'  `
                    -includeFilesOfType $includeFilesOfType `
                    -dontTruncateTheseFiles $dontTruncateTheseFiles  `
                    -ignoreFilesMatching $ignoreFilesMatching  `
                    -dontRecurse $false  `
                    -verbose $verbose  `
                    -level ( $level+1) `
                    -maxRecursionDepth $maxRecursionDepth; 
                    $f.contents += $subdir;
                } else {
                    if ($dontTruncateTheseFiles -and $dontTruncateTheseFiles.contains($_.extension.toLower())){
                        $f.contents += $_.name 
                    } elseif (($includeFilesOfType -and $includeFilesOfType.contains($_.extension.toLower())) -or (! $includeFilesOfType)){
                        $listThisFile = $true;
                        if ($ignoreFilesMatching){
                            for ($i = 0; $i -lt $ignoreFilesMatching.Length; $i++){
                                if ($_.name -match $ignoreFilesMatching[$i]){
                                    $listThisFile = $false;
                                }
                            }
                        }
                        if ($listThisFile) {
                            if ($_.name -match (("([0-9_]+{0})" -f $_.extension))){
                                $basename = ($_.name.replace($Matches[1], ""));
                                if (($f.contents.Length -gt 0) -and (($f.contents[-1].getType()).name -eq "String")){
                                    if (($f.contents[-1].startsWith($basename)) -and ($f.contents[-1] -match ($_.Extension + "( \+ [0-9]+ more)*"))){
                                        $n++
                                        $f.contents[-1] = ($f.contents[-1] -replace "( \+ [0-9]+ more)$", "")  +  " + $n more";
                                    } else {
                                        $n=0;
                                        $f.contents += $_.name 
                                    }
                                } else {
                                    $f.contents += $_.name
                                }
                                
                            } else {
                                $n=0;
                                $f.contents += $_.name 
                            }
                        } 
                    }
                }
            }
        }
    }
    function toString{
        # convert to text
        param($listing, [string]$indent, [int]$level = 0)
        $textOut = @(($indent * $level) + $listing.directory);
        for ($i = 0; $i -lt $listing.contents.Length; $i++){
            if ($listing.contents[$i].getType().name -eq "Hashtable"){
                $textOut += toString $listing.contents[$i] $indent ($level + 1 ); #increments the spacing if there is any. The empty quotes avoid an error if $indent is unset
            } else {
                $textOut += ($indent * ($level+1)) + $listing.contents[$i];
            } 
        }
        return $textOut  -join("`n");
    }
    switch ($outputFormat) {
        "JSON" {
            if ($verbose -gt 1){Write-Host (ConvertTo-Json $f) -ForegroundColor Cyan;}
            return (ConvertTo-Json $f); break
        }
        "flatText"{
            $result = toString $f ""
            if ($verbose -gt 1){Write-Host ($result) -ForegroundColor Cyan;}
            return ($result); break
        }
        "indentedText"{
            $result = toString $f $indent 0;
            if ($verbose -gt 1){Write-Host ($result) -ForegroundColor Cyan;}
            return ($result); break
        }
        Default {
            return $f; break
        }
    }
}


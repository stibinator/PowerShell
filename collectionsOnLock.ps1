function Get-RandomPicFromMV{
    Param(
        # this filters out the laserdisk images. Could be higher.
        [int32]$minResolution = (728 * 552), 
        # path to save images
        [string]$outPath = ($env:TEMP),
        # output image file name
        [string]$outName = "MVImage"
    )
    $apiURL = "https://collections.museumvictoria.com.au/api/search/?"
    $options = @(
        "hasimages=yes", 
        "perpage=1"
        )
    $searchURL = $apiURL + ($options -join "&")
    $result = $false
    $attempts = 0
    while (! ($result -or $attempts -gt 10)){
        $randoPage = Get-Random((Invoke-RestMethod -Uri ($searchURL +"&envelope=true")).headers.totalResults)
        $media = (Invoke-RestMethod -Uri ( $searchURL + "&page=" + $randoPage)).media
        #  some entries have more than one media object
        if ($media.length){ 
            $media = $media[(get-random($media.length))]
        }
        if (($media.large.width * $media.large.height) -gt $minResolution){
            write-host $searchURL
            write-host $media.large.width, "x", $media.large.height, $media.caption
            $photogURI = $media.large.uri
            # Not sure what the image format will be. 
            # Mostly seems to be jpg, but we'll match the extension at the end of the URI
            $extension = "." + $photogURI.split(".")[-1]
            if (! $extension){$extension = ".jpg"}
            $outfile = join-path $outPath ($outName + $extension)
            (New-Object Net.webclient).DownloadFile($photogURI, $outfile)
            $result = @{caption = $media.caption; file = (get-item $outfile)}
        }
    }
    return $result
}
function global:au_GetLatest {
    # 1. Ping the JDownloader Core Update API to detect version changes
    $UpdateUrl = 'https://jdownloader.org'
    try {
        $Response = Invoke-RestMethod -Uri $UpdateUrl -Method Get -UseBasicParsing -TimeoutSec 15
        if ($Response -match 'rev=(\d+)') { 
            $Revision = $Matches[1] 
        } else { 
            $Revision = "180482" 
        }
    } catch {
        Write-Error "Could not communicate with JDownloader update registry."
        return $null
    }

    # Generate the sequential package version based on the live revision
    $Version = "$Revision.0.0"

    # 2. Point AU to your stable Mega direct-download link as the source binary
    # Whenever you update your custom installer binary on Mega, update this URL if the file ID changes.
    $Url64 = "https://mega.nz/file/YOUR_MEGA_FILE_ID#YOUR_FILE_KEY"

    return @{
        Version = $Version
        URL64   = $Url64
    }
}

function global:au_SearchReplace {
    StandardNuspec
    StandardChocolateyInstall
}
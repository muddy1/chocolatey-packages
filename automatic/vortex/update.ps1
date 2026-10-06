import-module au

function global:au_GetLatest {
    # Fetch the latest release details directly from the GitHub repository API
    $release = Invoke-RestMethod 'https://api.github.com/repos/Nexus-Mods/Vortex/releases/latest'
    
    # Extract version by trimming the leading 'v' if present (e.g., v1.16.6 -> 1.16.6)
    $version = $release.tag_name -replace '^v'
    
    # Locate the setup executable asset inside the release payload
    $asset = $release.assets | Where-Object { $_.name -match 'vortex-setup-.*\.exe$' } | Select-Object -First 1
    if (!$asset) { throw "Could not find Vortex setup executable in GitHub release assets." }
    
    $url = $asset.browser_download_url

    return @{
        Version = $version
        URL     = $url
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            '(?i)(^\s*\$url\s*=\s*'')(.*?)(''.*)' = "`$1$($Latest.URL)`$3"
            '(?i)(^\s*checksum\s*=\s*'')(.*?)(''.*)' = "`$1$($Latest.Checksum32)`$3"
        }
    }
}

update -ChecksumFor 32














import-module au

# Function to fetch the latest release metadata for VRoid Studio
function global:au_GetLatest {
    # Request the official download page or release feed to extract the dynamic URL
    # (Pixiv often hosts the latest win.exe link via their redirect or release notes)
    $downloadPage = Invoke-WebRequest -Uri "https://vroid.com/en/studio" -UseBasicParsing
    
    # Alternatively, parse the current release URL pattern dynamically if tracking GitHub/API releases,
    # or use an AU regex mapper against the download distribution endpoint.
    
    # Let's target the dynamic download pattern:
    # Example pattern matching: https://download.vroid.com/dist/{token}/VRoidStudio-v{version}-win.exe
    
    $regex = 'https://download\.vroid\.com/dist/([^/]+)/VRoidStudio-v([\d\.]+)-win\.exe'
    
    if ($downloadPage.Content -match $regex) {
        $token   = $Matches[1]
        $version = $Matches[2]
        $url     = "https://download.vroid.com/dist/$token/VRoidStudio-v$version-win.exe"
    } else {
        throw "Could not dynamically resolve the VRoid Studio download token and version."
    }

    return @{
        Version = $version
        URL     = $url
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            # Targets the dynamic URL including the changing token hash
            "(?i)(^\s*`$url\s*=\s*')(.*?)('.*)" = "`$1$($Latest.URL)`$3"
        }
        "vroid-studio.nuspec" = @{
            # Targets the package version tag
            "(<version>)(.*?)(</version>)" = "`$1$($Latest.Version)`$3"
        }
    }
}

update -ChecksumFor 32
















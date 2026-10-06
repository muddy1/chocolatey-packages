import-module au

function global:au_GetLatest {
    try {
        $r = Invoke-RestMethod 'https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/a/AppWork/JDownloader' -Headers @{ 'User-Agent' = 'Chocolatey-AU' } -TimeoutSec 15
        $versions = $r | Where-Object type -eq 'dir' | Select-Object -ExpandProperty name
        $latest = $versions | Sort-Object { [version]$_ } -ErrorAction SilentlyContinue | Select-Object -Last 1
        if (-not $latest) { $latest = $versions | Select-Object -Last 1 }
        if (-not $latest) { $latest = '2.0.1' }
        return @{ Version = $latest }
    } catch {
        return @{ Version = '2.0.1' }
    }
}

function global:au_SearchReplace {
    @{
        "jdownloader.nuspec" = @{
            "(<version>)(.*?)(</version>)" = "`$1$($Latest.Version)`$3"
        }
    }
}

update -NoCheckUrl

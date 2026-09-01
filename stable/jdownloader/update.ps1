function global:au_GetLatest {
    # ... [Previous MEGAcmd download logic here] ...

    # Calculate the SHA256 of the fresh file the Nodders just grabbed
    $hash = (Get-FileHash $installer.FullName -Algorithm SHA256).Hash

    return @{
        Version      = $version
        URL          = $megaUrl
        FileName     = $installer.Name
        Path         = $installer.FullName
        Checksum     = $hash
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            # Targets: Join-Path $toolsDir 'Setup\JDownloader2Setup_windows-amd64_v1_8_0_482.exe'
            "(?i)(Join-Path\s+`$toolsDir\s+'Setup\\)(.*?)('.*)" = "`$1$($Latest.FileName)`$3"
            
            # Targets: checksum      = 'F4346F7DCEDD3E885F271FBB3182E9E7CEF3BBD02C6B034F7D1B959856D100E7'
            "(?i)(^\s*checksum\s*=\s*')(.*?)('.*)" = "`$1$($Latest.Checksum)`$3"
        }
        "jdownloader.nuspec" = @{
            # Targets: <version>180482</version>
            "(<version>)(.*?)(</version>)" = "`$1$($Latest.Version)`$3"
        }
    }
}
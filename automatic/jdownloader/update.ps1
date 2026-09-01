import-module au

$megaUrl = 'https://mega.nz/file/LNcXQJqS#6SaV0-JXG580T-BMSrp_xjepsEyDYjV8danX854mC9w'

function global:au_GetLatest {
    Write-Host "Downloading latest installer from Mega..."
    mega-get $megaUrl .

    $installer = Get-ChildItem -Filter "JDownloader2Setup*.exe" | Select-Object -First 1
    if (!$installer) { throw "Failed to download JDownloader installer from Mega." }

    # Extract version from filename or fallback
    if ($installer.Name -match 'v(\d+)_(\d+)_(\d+)_(\d+)') {
        $version = "$($Matches[1]).$($Matches[2]).$($Matches[3]).$($Matches[4])"
    } else {
        $version = '1.8.0.482'
    }

    # Calculate the SHA256 of the fresh file[cite: 9]
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
            # Targets: Join-Path $toolsDir 'Setup\JDownloader2Setup_windows-amd64_v1_8_0_482.exe'[cite: 9]
            "(?i)(Join-Path\s+`$toolsDir\s+'Setup\\)(.*?)('.*)" = "`$1$($Latest.FileName)`$3"
            
            # Targets: checksum      = '...'[cite: 9]
            "(?i)(^\s*checksum\s*=\s*')(.*?)('.*)" = "`$1$($Latest.Checksum)`$3"
        }
        "jdownloader.nuspec" = @{
            # Targets: <version>...</version>[cite: 9]
            "(<version>)(.*?)(</version>)" = "`$1$($Latest.Version)`$3"
        }
    }
}

update -ChecksumFor none
$ErrorActionPreference = 'Stop'
Uninstall-ChocolateyZipPackage -Packagename $env:ChocolateyPackageName -ZipFileName 'GameSaveManager_3.1.571.0.zip'

$installDir = Join-Path $env:ProgramFiles 'gamesave manager'
if (Test-Path -LiteralPath $installDir) {
    Remove-Item -LiteralPath $installDir -Recurse -Force -ErrorAction SilentlyContinue
}



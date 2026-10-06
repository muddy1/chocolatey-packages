$ErrorActionPreference = 'Stop'

# Target the main installation directory directly
$installDir = "$env:ProgramFiles\JDownloader"

if (-not [string]::IsNullOrWhiteSpace($installDir) -and (Test-Path -LiteralPath $installDir)) {
    Remove-Item -LiteralPath $installDir -Recurse -Force -ErrorAction SilentlyContinue
}

# --- Remove desktop icons if they exist ---
$desktopPaths = @(
    "$env:PUBLIC\Desktop",
    "$env:USERPROFILE\Desktop"
)

foreach ($desktop in $desktopPaths) {
    if (Test-Path -LiteralPath $desktop) {
        Get-ChildItem -LiteralPath $desktop -Filter "JDownloader*.lnk" -ErrorAction SilentlyContinue |
            Remove-Item -Force -ErrorAction SilentlyContinue
    }
}
# -----------------------------------------------

# Clean up the registry uninstall keys so Chocolatey and Windows forget it ever existed
$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

foreach ($path in $registryPaths) {
    Get-ItemProperty -Path $path -ErrorAction SilentlyContinue |
        Where-Object { $_.DisplayName -like 'JDownloader*' } |
        ForEach-Object {
            Remove-Item $_.PSPath -Recurse -Force -ErrorAction SilentlyContinue
        }
}
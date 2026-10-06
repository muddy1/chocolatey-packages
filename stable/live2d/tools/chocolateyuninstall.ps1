$ErrorActionPreference = 'Stop'

$softwareName = 'live2d*'

# 1. Terminate any running Live2D processes so files aren't locked
Get-Process -Name 'Live2D*' -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

# 2. Hunt down the exact registry keys using Chocolatey's native helper
[array]$keys = Get-UninstallRegistryKey -SoftwareName $softwareName

foreach ($key in $keys) {
    # If the registry knows the exact install folder, safely validate and remove it
    $installPath = $key.InstallLocation
    if (-not [string]::IsNullOrWhiteSpace($installPath) -and ($installPath.Trim().Length -gt 3) -and (Test-Path -LiteralPath $installPath)) {
        Remove-Item -LiteralPath $installPath -Recurse -Force -ErrorAction SilentlyContinue
    }

    # Remove registry key itself so it vanishes from Windows "Add/Remove Programs"
    if (-not [string]::IsNullOrWhiteSpace($key.PSPath) -and (Test-Path -LiteralPath $key.PSPath)) {
        Remove-Item -LiteralPath $key.PSPath -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# 3. Sweep the default standard directories just to be absolutely sure
$commonPaths = @(
    "$env:ProgramFiles\Live2D Cubism*",
    "${env:ProgramFiles(x86)}\Live2D Cubism*",
    "$env:ProgramData\Live2D*"
)
foreach ($path in $commonPaths) {
    if (Test-Path -Path $path) {
        Get-Item -Path $path -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# 4. Sweep the Desktop and Start Menu for any lingering shortcuts
$shortcuts = @(
    "$env:Public\Desktop\Live2D*.lnk",
    "$env:USERPROFILE\Desktop\Live2D*.lnk",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Live2D*"
)
foreach ($shortcut in $shortcuts) {
    if (Test-Path -Path $shortcut) {
        Get-Item -Path $shortcut -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Live2D has been completely removed" -ForegroundColor Green
$ErrorActionPreference = 'SilentlyContinue'

$softwareName = 'live2d*'

# 1. Terminate any running Live2D processes so files aren't locked
Get-Process -Name "Live2D*" | Stop-Process -Force

# 2. Hunt down the exact registry keys using Chocolatey's native helper
[array]$keys = Get-UninstallRegistryKey -SoftwareName $softwareName

foreach ($key in $keys) {
    # If the registry knows the exact install folder, remove it first
    $installPath = $key.InstallLocation
    if (-not [string]::IsNullOrEmpty($installPath) -and (Test-Path $installPath)) {
        Remove-Item -Path "$installPath\*" -Recurse -Force
        Remove-Item -Path $installPath -Recurse -Force
    }
    
    # remove registry key itself so it vanishes from Windows "Add/Remove Programs"
    if ($key.PSPath) {
        Remove-Item -Path $key.PSPath -Recurse -Force
    }
}

# 3. Sweep the default standard directories just to be absolutely sure
$commonPaths = @(
    "$env:ProgramFiles\Live2D Cubism*",
    "${env:ProgramFiles(x86)}\Live2D Cubism*",
    "$env:ProgramData\Live2D*"
)
foreach ($path in $commonPaths) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force
    }
}

# 4. Sweep the Desktop and Start Menu for any lingering shortcuts
$shortcuts = @(
    "$env:Public\Desktop\Live2D*.lnk",
    "$env:USERPROFILE\Desktop\Live2D*.lnk",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Live2D*"
)
foreach ($shortcut in $shortcuts) {
    if (Test-Path $shortcut) {
        Remove-Item -Path $shortcut -Recurse -Force
    }
}

Write-Host "Live2D has been completely removed" -ForegroundColor Green
$ErrorActionPreference = 'Stop'

# 1. Resolve or bootstrap winget
$wingetCmd = Get-Command -Name 'winget.exe' -ErrorAction SilentlyContinue

if (-not $wingetCmd) {
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe -ErrorAction SilentlyContinue
    $wingetCmd = Get-Command -Name 'winget.exe' -ErrorAction SilentlyContinue
}

# 2. Resolve native binary path
$wingetPath = if ($wingetCmd) {
    $wingetCmd.Source
} else {
    $candidatePaths = @(
        (Join-Path $env:LOCALAPPDATA 'Microsoft\WindowsApps\winget.exe'),
        (Join-Path $env:ProgramFiles 'WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe')
    )
    $resolved = $candidatePaths | Where-Object { Test-Path $_ } | Select-Object -First 1
    if ($resolved) { $resolved } else { 'winget.exe' }
}

# 3. Background deployment via WinGet
$appId = 'AppWork.JDownloader'
$arguments = @(
    'install',
    '--id', $appId,
    '--exact',
    '--silent',
    '--accept-package-agreements',
    '--accept-source-agreements'
)

Write-Host "Deploying $appId via WinGet ($wingetPath)..."
$process = Start-Process -FilePath $wingetPath -ArgumentList $arguments -Wait -PassThru -NoNewWindow

if ($process.ExitCode -ne 0) {
    throw "WinGet installation of $appId failed with exit code $($process.ExitCode)."
}

$ErrorActionPreference = 'Stop'

# 1. Resolve winget binary
$wingetCmd = Get-Command -Name 'winget.exe' -ErrorAction SilentlyContinue

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

# 2. Background silent uninstall via WinGet
$appId = 'AppWork.JDownloader'
$arguments = @(
    'uninstall',
    '--id', $appId,
    '--silent'
)

Write-Host "Uninstalling $appId via WinGet ($wingetPath)..."
$process = Start-Process -FilePath $wingetPath -ArgumentList $arguments -Wait -PassThru -NoNewWindow

if ($process.ExitCode -ne 0) {
    Write-Warning "WinGet uninstallation of $appId exited with code $($process.ExitCode)."
}

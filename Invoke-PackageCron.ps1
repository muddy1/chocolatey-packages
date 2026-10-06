<#
.SYNOPSIS
    Invoke-PackageCron.ps1 - Automated Chocolatey package updater and maintenance runner.
.DESCRIPTION
    Executes Chocolatey AU updates across repository packages in background or CI/CD mode.
    Manages module dependencies, structured log rotation, execution priority, and automated
    Git commits for updated package definitions.
.PARAMETER WhatIf
    Run in dry-run mode without modifying package manifests or pushing releases.
.PARAMETER Root
    Root directory containing packages to check (defaults to .\automatic).
.PARAMETER Name
    Specific package name(s) to target for updates.
.PARAMETER Push
    Push successfully packaged versions to chocolatey.org (requires CHOCOLATEY_API_KEY).
.PARAMETER RegisterTask
    Registers the Windows Scheduled Task to execute weekly at 3:00 AM (Idle priority).
.PARAMETER GitCommitPush
    Automatically commits and pushes updated package manifests back to Git (ideal for CI/CD).
#>
[CmdletBinding()]
param(
    [switch]$WhatIf,
    [string]$Root = "$PSScriptRoot\automatic",
    [string[]]$Name,
    [switch]$Push,
    [switch]$RegisterTask,
    [switch]$GitCommitPush
)

$LogDir = Join-Path $PSScriptRoot "logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }

$LogFile = Join-Path $LogDir ("choco_cron_{0:yyyyMMdd_HHmmss}.log" -f (Get-Date))

function Write-CronLog ($msg) {
    $line = "[{0:yyyy-MM-dd HH:mm:ss}] {1}" -f (Get-Date), $msg
    Add-Content -Path $LogFile -Value $line -Force
    Write-Host $line
}

if ($RegisterTask) {
    Write-Host "Registering Chocolatey-PackageUpdater Scheduled Task..."
    $action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$PSScriptRoot\Invoke-PackageCron.ps1`""
    $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 3am
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Hours 2) -Priority 7
    $principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive -RunLevel Highest
    Register-ScheduledTask -TaskName 'Chocolatey-PackageUpdater' -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Force
    Write-Host "Task 'Chocolatey-PackageUpdater' successfully registered to run weekly (Sunday @ 3:00 AM)."
    return
}

Write-CronLog "=== Chocolatey Automated Package Updater Initialized ==="
Write-CronLog "Repository Root: $PSScriptRoot"
Write-CronLog "Target Package Root: $Root"

# 1. Dependency Self-Healing (AU Module)
$userModulePaths = @(
    (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'WindowsPowerShell\Modules'),
    (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'PowerShell\Modules')
)
foreach ($mp in $userModulePaths) {
    if ((Test-Path $mp) -and ($env:PSModulePath -notlike "*$mp*")) {
        $env:PSModulePath = "$mp;$env:PSModulePath"
    }
}

if (-not (Get-Module -ListAvailable -Name au)) {
    Write-CronLog "AU PowerShell module not found. Installing from PSGallery..."
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser -ErrorAction SilentlyContinue | Out-Null
        Install-Module -Name au -Scope CurrentUser -Force -AllowClobber -SkipPublisherCheck -ErrorAction Stop
        Write-CronLog "AU module installed successfully."
    } catch {
        Write-CronLog "Failed to install AU module: $_"
        exit 1
    }
} else {
    Write-CronLog "AU module verified."
}

try {
    Import-Module au -ErrorAction Stop
    Write-CronLog "AU module loaded."
} catch {
    Write-CronLog "Failed to import AU module: $_"
    exit 1
}

# 2. Log Rotation (Keep last 14 logs)
try {
    Get-ChildItem -Path $LogDir -Filter "choco_cron_*.log" | 
        Sort-Object CreationTime -Descending | 
        Select-Object -Skip 14 | 
        Remove-Item -Force -ErrorAction SilentlyContinue
} catch {}

# 3. Execution
try {
    $updateScript = Join-Path $PSScriptRoot "update_all.ps1"
    if (-not (Test-Path $updateScript)) {
        Write-CronLog "Error: update_all.ps1 not found at $updateScript"
        exit 1
    }

    $params = @{ Root = $Root }
    if ($WhatIf) { $params['WhatIf'] = $true }
    if ($Name)   { $params['Name'] = $Name }

    if ($Push -or ($env:au_Push -eq 'true')) {
        $env:au_Push = 'true'
    }

    Write-CronLog "Invoking update_all.ps1..."
    & $updateScript @params *>&1 | Tee-Object -FilePath $LogFile -Append
    Write-CronLog "Update execution finished."

    # 4. Optional Git Commit & Push for CI/CD environments
    if ($GitCommitPush) {
        Write-CronLog "Checking for repository changes to commit..."
        $status = git status --porcelain
        if ($status) {
            Write-CronLog "Detected changes in repository. Committing and pushing..."
            git add automatic/ stable/ Update-AUPackages.md
            git commit -m "[AU] Update packages [skip ci]"
            git push
            Write-CronLog "Changes successfully committed and pushed to remote."
        } else {
            Write-CronLog "No package updates detected. Repository is clean."
        }
    }

    Write-CronLog "=== Chocolatey Automated Package Updater Completed Successfully ==="
} catch {
    Write-CronLog "Execution Exception: $_"
    exit 1
}

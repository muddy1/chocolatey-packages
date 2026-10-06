<#
.SYNOPSIS
    Automated update_all.ps1 runner for Chocolatey AU and CI/CD pipelines.
#>
[CmdletBinding()]
param(
    [string[]]$Name,
    [string]$ForcedPackages,
    [string]$Root = "$PSScriptRoot\automatic",
    [switch]$WhatIf
)

$Options = [ordered]@{
    WhatIf        = $WhatIf.IsPresent
    Force         = $false
    Timeout       = 100
    UpdateTimeout = 1200
    Threads       = 5
    Push          = $Env:au_Push -eq 'true'
    PushAll       = $true
    PluginPath    = ''
    IgnoreOn      = @('The operation has timed out', 'Internal Server Error', 'Service Temporarily Unavailable')
    RepeatOn      = @('The operation has timed out', 'Internal Server Error', 'An exception occurred during a WebClient request')

    Report = @{
        Type = 'markdown'
        Path = "$PSScriptRoot\Update-AUPackages.md"
        Params= @{
            Github_UserRepo = $Env:GITHUB_REPOSITORY
            NoAppVeyor  = $true
        }
    }

    RunInfo = @{
        Exclude = 'password', 'apikey', 'apitoken'
        Path    = "$PSScriptRoot\update_info.xml"
    }

    ForcedPackages = $ForcedPackages -split ' '
    BeforeEach = {
        param($PackageName, $Options )

        $pattern = "^${PackageName}(?:\\(?<stream>[^:]+))?(?:\:(?<version>.+))?$"
        $p = $Options.ForcedPackages | ? { $_ -match $pattern }
        if (!$p) { return }

        $global:au_Force         = $true
        $global:au_IncludeStream = $Matches['stream']
        $global:au_Version       = $Matches['version']
    }
}

if ($ForcedPackages) { Write-Host "FORCED PACKAGES: $ForcedPackages" }
$global:au_Root         = $Root

Write-Host "Starting updateall loop..."
$global:info = updateall -Name $Name -Options $Options

if ($global:info.Error -and ($global:info.Error.Count -gt 0)) {
    Write-Warning "Errors occurred during update run."
}

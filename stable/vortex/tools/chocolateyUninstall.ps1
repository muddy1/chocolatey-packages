$ErrorActionPreference = 'Stop'

$packageName = 'vortex'
$programUninstallEntryName = 'Vortex*'

[array]$key = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName

if ($key.Count -eq 1) {
  $file = $key[0].UninstallString -replace ('/allusers', '')
  $packageArgs['file'] = $file
  Uninstall-ChocolateyPackage @packageArgs
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
$ErrorActionPreference = 'Stop'

$packageName = 'dismtools'
$programUninstallEntryName = 'dismtools*'

$registry = Get-UninstallRegistryKey -SoftwareName $programUninstallEntryName
$file = $registry.UninstallString -replace ('/allusers', '')

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  silentArgs     = '/SP- /VERYSILENT'
  validExitCodes = @(0)
  file           = $file
}

Uninstall-ChocolateyPackage @packageArgs
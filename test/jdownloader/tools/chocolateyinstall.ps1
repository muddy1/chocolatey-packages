$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url64          = '[[Url64]]'
  softwareName   = 'JDownloader*'
  silentArgs     = '-q -overwrite -VexecuteLauncherAction$Boolean=false'
  validExitCodes = @(0, 3010, 1641, 22)
  checksum64     = '[[Checksum64]]'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
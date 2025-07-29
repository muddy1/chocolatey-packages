$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.vroid.com/dist/0E03cQckxU/VRoidStudio-v2.3.0-win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'vroid-studio*'

  checksum      = 'EA000CD749190F1BDC85B7C51A757F1525989422AB4721846650411F8E5791DC'
  checksumType  = 'sha256'

  silentArgs    = "/SP- /VERYSILENT"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















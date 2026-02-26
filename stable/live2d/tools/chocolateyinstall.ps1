$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cubism.live2d.com/editor/bin/Live2D_Cubism_Setup_5.3.01.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'live2d*'

  checksum      = 'ff6b4c63a36fb2d4fbac54a2c58ea583c4967317527cc9ea5e62fb103d2e05ba'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cubism.live2d.com/editor/bin/Live2D_Cubism_Setup_5.3.02%20beta1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'live2d*'

  checksum      = '30f51f4e34aad741bed2a935577b4540c87c1b2ceccfc23fb3fede1b9c30228b'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
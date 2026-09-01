$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cubism.live2d.com/editor/bin/Live2D_Cubism_Setup_5.3.04%20beta1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'live2d*'

  checksum      = '51927639B187DEA9EC9674473B8516DDD0AA9A40B446F0ED10BB9F9A25B4AB58'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://cubism.live2d.com/editor/bin/Live2D_Cubism_Setup_5.3.04.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'live2d*'

  checksum      = '457421E617CC836ECED24236CA3564935580B2D3B26BDEAB9A304A42B83308BC'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.vroid.com/dist/Wigy2INowd/VRoidStudio-v2.8.0-win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'vroid-studio*'

  checksum      = '0D7A2EA6C82874D0A69487DF82D9318BE2D3DFC280C5ADE80EE8570056D0D9F4'
  checksumType  = 'sha256'

  silentArgs    = "/SP- /VERYSILENT"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















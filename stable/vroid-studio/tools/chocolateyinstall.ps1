$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.vroid.com/dist/WIQ8Wy7INR/VRoidStudio-v2.1.5-win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'vroid-studio*'

  checksum      = 'B576E3E34CDEED377CDC3249780A6EBA002A769B20814CBD2A925B3705EFB568'
  checksumType  = 'sha256'

  silentArgs    = "/SP- /VERYSILENT"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.vroid.com/dist/bGnQioNBC8/VRoidStudio-v2.3.1-win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'vroid-studio*'

  checksum      = '32631E00AEC1F1659A2BEDA2384CDC9967566CA34FBB3FD57E5D43609BBA990F'
  checksumType  = 'sha256'

  silentArgs    = "/SP- /VERYSILENT"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.vroid.com/dist/tEuggsKrtY/VRoidStudio-v2.11.0-win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'vroid-studio*'

  checksum      = '6d5887a8682ff6012a8e9ba9de11b20c42922e8d6a83a5388dcd80dfb5667280'
  checksumType  = 'sha256'

  silentArgs    = "/SP- /VERYSILENT"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















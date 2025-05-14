
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.touch-portal.com/downloads/TouchPortal_Setup_release.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'touch-portal*'

  checksum      = '3AE3B301562A3D67319FA70DD10BBFB07B461E05F10DA1A2C897A6B093C5F1C4'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
















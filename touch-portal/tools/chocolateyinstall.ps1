
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.touch-portal.com/downloads/TouchPortal_Setup_release.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'touch-portal*'

  checksum      = '9A18C4CBA72CEA360FBC21D60FDBE3B464F1511279733ABCF2C466247E7DC0A8'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /FORCECLOSEAPPLICATIONS"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
















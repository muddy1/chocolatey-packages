
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.touch-portal.com/downloads/TouchPortal_Setup_release.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'touchportal*'

  checksum      = '7BD419055AE7C35DB20F700B31144D8FC538937DB0C848F614DB82E081C93BF3'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
















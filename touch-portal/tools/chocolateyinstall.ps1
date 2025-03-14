
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.touch-portal.com/downloads/TouchPortal_Setup_release.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'touch-portal*'

  checksum      = '73E112B55A06A4037B5208509C4109686A5E4942F1EB5F1098BB218C9D8BBD28'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /FORCECLOSEAPPLICATIONS"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
















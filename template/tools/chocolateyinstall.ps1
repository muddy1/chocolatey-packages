
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = '*'

  checksum      = ''
  checksumType  = 'sha256'

  silentArgs    = ""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















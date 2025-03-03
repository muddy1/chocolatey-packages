
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://storage.googleapis.com/nizima-docs/apps/nizima-live/nizimaLiveSetup2.1.2.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'nizima-live*'

  checksum      = '33F0DAB51C92CC4D1AA443E96710F1EC62B82860EB777D4F54FB59B6984F633D'
  checksumType  = 'sha256'

  silentArgs    = "-quiet"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


















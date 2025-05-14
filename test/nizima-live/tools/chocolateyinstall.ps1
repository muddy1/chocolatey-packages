$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe = 'AutoHotkey'
$ahkFile = "$toolsDir\install.ahk"
$url        = 'https://storage.googleapis.com/nizima-docs/apps/nizima-live/nizimaLiveSetup2.2.1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'nizima-live*'

  checksum      = '5A5532B6567022F4E0707F45C48B9715B41ED052A579AD6730C9E6539EF6F5E1'
  checksumType  = 'sha256'

  validExitCodes= @(0, 3010, 1641)
}
Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
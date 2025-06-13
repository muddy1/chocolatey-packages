$ErrorActionPreference = 'Stop';

$packageName = 'flakiesadbgui'
$url         = 'https://flakie.co.uk/downloads/FlakieADBGUI.zip'
$checksum    = 'CCB72D93BF7FD582E9AC10A43692E83E3B2D4B1B5495CD0D4EF2E9A36B212975'
$installDir  = '{0}\flakiesadb\' -f $Env:SystemDrive

$packageArgs = @{
  packageName    = $packageName
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}

Install-ChocolateyZipPackage @packageArgs


















$ErrorActionPreference = 'Stop';

$packageName = 'dismgui'
$url         = 'https://github.com/mikecel79/DISMGUI/releases/download/4.0/DISM.GUI.zip'
$checksum    = '0DA4B2F08424CECA3EA1F4996566366B27C9B5A6E1C0EF37E89BA1224BF91041'
$installDir  = '{0}\dismgui' -f $Env:SystemDrive

$packageArgs = @{
  packageName    = $packageName
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}

Install-ChocolateyZipPackage @packageArgs


















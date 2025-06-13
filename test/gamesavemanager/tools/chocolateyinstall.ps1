$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  url            = 'https://www.gamesave-manager.com/file/02420ae5-85b8-4528-bf94-7853b1e5316b/'
  checksum       = '87F7CD9AA0EE6A8D41517D5F5133AD963EA28D2F050697A4FB853812268B85F6'
  checksumType   = 'sha256'
  unzipLocation  = "c:\Program Files\gamesave manager"
  softwareName   = 'gamesavemanager'
}
Install-ChocolateyZipPackage @packageArgs


















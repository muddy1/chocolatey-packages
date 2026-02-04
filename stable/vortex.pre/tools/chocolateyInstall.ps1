$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Nexus-Mods/Vortex/releases/download/v1.16.0-beta.5/vortex-setup-1.16.0-beta.5.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'vortex*'

  checksum      = 'A78FCD826FD69F28C71BE531757A131A19286B61682D4EAB6083AFA2F69E6322'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


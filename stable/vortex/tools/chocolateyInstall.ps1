$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Nexus-Mods/Vortex/releases/download/v1.16.1/vortex-setup-1.16.1.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'vortex*'

  checksum      = 'BAE1A465E8C82BA71999E96AB05B68736A4381800111607D2F59C13BD8991E82'
  checksumType  = 'sha256'

  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs


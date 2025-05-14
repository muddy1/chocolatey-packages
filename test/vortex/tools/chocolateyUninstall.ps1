Uninstall-ChocolateyPackage @packageArgs
﻿$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/Nexus-Mods/Vortex/releases/download/v1.13.7/vortex-setup-1.13.7.exe'
$fileName = [System.IO.Path]::GetFileName($url)
$fileLocation = Join-Path $toolsDir $fileName
$checksum = ''

$webFileArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileFullPath = $fileLocation
  url          = $url
  checksum     = $checksum
  checksumType = 'sha256'
}

Get-ChocolateyWebFile @webFileArgs

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'vortex'
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Uninstall-ChocolateyPackage @packageArgs
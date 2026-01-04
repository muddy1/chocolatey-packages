$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'JDownloader2Setup_windows-amd64_v21_0_7.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file         = $fileLocation

  softwareName  = 'jdownloader*'

  checksum      = '504B6AF59EA6C42582AFDCF48F3CB8165CD92DAACECAC9FB01FFF67054617E45'
  checksumType  = 'sha256'

  silentArgs    = "-q"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for it
Remove-Item $toolsDir\*.exe -ea 0 -Force

















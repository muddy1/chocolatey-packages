$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerPath = Join-Path $toolsDir 'Setup\JDownloader2Setup_windows-amd64_v1_8_0_482.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = $installerPath
  softwareName  = 'JDownloader*'
  silentArgs    = '-q -overwrite -VexecuteLauncherAction$Boolean=false'
  validExitCodes= @(0, 3010, 1641, 22)
  checksum      = 'F4346F7DCEDD3E885F271FBB3182E9E7CEF3BBD02C6B034F7D1B959856D100E7'
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Remove-Item (Join-Path $toolsDir 'setup\*.exe') -ErrorAction SilentlyContinue -Force















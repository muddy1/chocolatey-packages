$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerPath = Join-Path $toolsDir 'Setup\JDownloader2Setup_windows-amd64_v1_8_0_504.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = $installerPath
  softwareName  = 'JDownloader*'
  silentArgs    = '-q -overwrite -VexecuteLauncherAction$Boolean=false'
  validExitCodes= @(0, 3010, 1641, 22)
  checksum      = '969390C40FD27EA5DB09B18DF2F7D6C22D3B109A09ED55592637350DBC7EEDC8'
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Remove-Item (Join-Path $toolsDir 'setup\*.exe') -ErrorAction SilentlyContinue -Force















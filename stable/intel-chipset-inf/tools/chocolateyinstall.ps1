
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'SetupChipset.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file         = $fileLocation

  softwareName  = 'intel-inf-utility*'

  checksum      = '6CDDEEAFC32607FF914FD6038E475BF876E55804A9F759ECA773E5EA144AF481'
  checksumType  = 'sha256'

  silentArgs    = "-s -norestart"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

# Remove the installers as there is no more need for it
Remove-Item $toolsDir\*.exe -ea 0 -Force
















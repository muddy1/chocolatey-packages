$ErrorActionPreference = 'Stop';
$toolsDir 			   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$pp                    = Get-PackageParameters
$shortcutName          = 'flakiesADB.lnk'
$url                   = 'https://flakie.co.uk/downloads/FlakieADBGUI.zip'
$exepath               = ([System.IO.Path]::Combine($toolsDir,  'FlakieADBGUI.exe'))

$packageArgs = @{
  Url           = $url
  Checksum      = 'CCB72D93BF7FD582E9AC10A43692E83E3B2D4B1B5495CD0D4EF2E9A36B212975'
  ChecksumType  = 'sha256'
  UnzipLocation = $toolsDir
  PackageName   = 'flakiesadbgui'
}

Install-ChocolateyZipPackage @packageArgs


if ($pp['desktopicon']) {
	$desktopicon = (Join-Path ([Environment]::GetFolderPath("Desktop")) $shortcutName)
	Write-Host -ForegroundColor green 'Adding ' $desktopicon
	Install-ChocolateyShortcut -ShortcutFilePath $desktopicon -TargetPath $exepath  -RunAsAdmin
}

if (!$pp['nostart']) {
	$starticon = (Join-Path ([environment]::GetFolderPath([environment+specialfolder]::Programs)) $shortcutName)
	Write-Host -ForegroundColor green 'Adding ' $starticon
	Install-ChocolateyShortcut -ShortcutFilePath $starticon -TargetPath $exepath  -RunAsAdmin
}
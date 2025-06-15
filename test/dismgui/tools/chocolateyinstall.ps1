$ErrorActionPreference = 'Stop';
$toolsDir 			   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$pp                    = Get-PackageParameters
$shortcutName          = 'dismgui.lnk'
$url                   = 'https://github.com/mikecel79/DISMGUI/releases/download/4.0/DISM.GUI.zip'
$exepath               = ([System.IO.Path]::Combine($toolsDir,  'dism gui.exe'))
$softwareName          = 'Dism GUI'

$packageArgs = @{
  Url           = $url
  Checksum      = '0DA4B2F08424CECA3EA1F4996566366B27C9B5A6E1C0EF37E89BA1224BF91041'
  ChecksumType  = 'sha256'
  UnzipLocation = $toolsDir
  PackageName   = 'dismgui'
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

$installDir = if ($pp['InstallDir']) { $pp['InstallDir'] } else { $toolsDir }

Write-Host "Dism GUI is going to be installed in '$installDir'"









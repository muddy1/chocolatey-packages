$ErrorActionPreference = 'Stop'
$fileType = 'EXE'
$uninstaller = 'C:\Program Files (x86)\nizima LIVE\maintenancetool.exe' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe = 'AutoHotkey'
$ahkFile = "$toolsDir\uninstall.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = $fileType
  file          = $uninstaller
}
Start-Process $ahkExe $ahkFile
Uninstall-ChocolateyPackage @packageArgs



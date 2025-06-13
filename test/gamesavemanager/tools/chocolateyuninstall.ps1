$ErrorActionPreference = 'Stop' # stop on all errors
Uninstall-ChocolateyZipPackage -Packagename $env:ChocolateyPackageName -ZipFileName 'GameSaveManager_3.1.571.0.zip'

# Uninstall-ChocolateyZipPackage will remove the FILES from the archive.
# If you wish to remove the DIRECTORY they were extracted too,
# you'll additionally have to handle that in this script.
Remove-Item "c:\Program Files\gamesave manager"



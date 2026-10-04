# Chocolatey Packages

Automated and maintained Chocolatey packages repository for [muddy1](https://github.com/muddy1).

[![Run Chocolatey AU](https://github.com/muddy1/chocolatey-packages/actions/workflows/choco-au.yml/badge.svg)](https://github.com/muddy1/chocolatey-packages/actions/workflows/choco-au.yml)

## Folder Structure

* **`automatic/`** - Packages automatically updated and published using [Chocolatey AU](https://github.com/chocolatey-community/chocolatey-au).
* **`stable/`** - Stable, released package definitions maintained in the repository.
* **`test/`** - Sandbox environment for developing and validating packages before promoting them to `automatic` or `stable`.
* **`deprecated/`** - Packages that are obsolete or no longer maintained.
* **`icons/`** - Centralized image and icon assets for package metadata.
* **`screenshots/`** - Centralized screenshot assets.
* **`setup/`** - Scripts and resources for Chocolatey AU setup and configuration.

## Requirements

* [Chocolatey CLI](https://chocolatey.org/) (`choco.exe`)
* PowerShell 5.1+ or PowerShell 7+
* [chocolatey-au module](https://github.com/chocolatey-community/chocolatey-au)

## Updating Packages

To run updates locally with AU:

```powershell
# Update all automatic packages
.\update_all.ps1

# Update a specific package
.\update_all.ps1 -Name jdownloader
```



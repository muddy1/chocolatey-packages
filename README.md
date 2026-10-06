# Chocolatey Packages

Automated and maintained Chocolatey packages repository by [muddy1](https://github.com/muddy1).

[![Chocolatey Package Updater](https://github.com/muddy1/chocolatey-packages/actions/workflows/choco-cron.yml/badge.svg)](https://github.com/muddy1/chocolatey-packages/actions/workflows/choco-cron.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.md)

---

## Package Catalog

| Package | Status | Automation | Description |
| :--- | :--- | :--- | :--- |
| **[vortex](automatic/vortex)** | Active | Automatic (AU) | Nexus Mods modern mod manager |
| **[jdownloader](automatic/jdownloader)** | Active | WinGet / AU | Free, open-source download management framework |
| **[dismtools](stable/dismtools.stable)** | Active | Stable | Graphical interface and project-based GUI for DISM |
| **[gamesavemanager](stable/gamesavemanager)** | Active | Stable | Automated game save backup and sync utility |
| **[intel-chipset-inf](stable/intel-chipset-inf)** | Active | Stable | Intel Chipset Device Software INF Utility |
| **[live2d](stable/live2d)** | Active | Stable | Live2D Cubism Editor for 2D dynamic animation |
| **[live2d.beta](stable/live2d.beta)** | Active | Stable | Live2D Cubism Editor (Beta channel) |
| **[touchportal](stable/touchportal)** | Active | Stable | Macro multi-action remote control for PC and streaming |
| **[vroid-studio](stable/vroid-studio)** | Active | Stable | 3D humanoid avatar creator by Pixiv |
| **[flakiesadb](stable/flakiesadb)** | Active | Stable | Android Debug Bridge utility toolkit |
| **[dismgui](deprecated/dismgui)** | Deprecated | Archived | Legacy DISM GUI (superseded by DISMTools) |

---

## Repository Structure

* **`automatic/`** - Packages automatically updated and published using [Chocolatey AU](https://github.com/chocolatey-community/chocolatey-au). Each contains an `update.ps1` script.
* **`stable/`** - Production-ready, validated package manifests.
* **`test/`** - Sandbox environment for authoring and validating packages before promotion.
* **`deprecated/`** - Retired packages preserved for historical reference.
* **`icons/`** - Centralized image and icon assets referenced by package nuspec manifests.
* **`screenshots/`** - Package screenshots and documentation media.

---

## Running Updates

### Autonomous CI/CD (GitHub Actions)
Updates run autonomously on a weekly schedule (Sunday at 03:00 UTC) via `.github/workflows/choco-cron.yml`. If upstream package updates are detected, packages are built, pushed to Chocolatey Community Repository, and updated manifests are committed back to the repository.

### Local Execution (Windows)
Run updates locally using the unified runner script:

```powershell
# Dry-run analysis (verify upstream versions without packaging)
.\Invoke-PackageCron.ps1 -WhatIf

# Update all automatic packages
.\Invoke-PackageCron.ps1

# Update a specific package
.\Invoke-PackageCron.ps1 -Name "vortex"

# Register local Windows Scheduled Task (runs weekly at 3:00 AM on Idle priority)
.\Invoke-PackageCron.ps1 -RegisterTask
```

For detailed cron and task scheduler configuration, see [CRON_SETUP.md](CRON_SETUP.md).

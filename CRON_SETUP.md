# Chocolatey Package Automated Maintenance & Cron Guide

This repository contains the automated maintenance and update pipeline for Chocolatey packages using the **Chocolatey Automatic Updater (AU)** module.

---

## Architecture Overview

The updater can be run both locally on Windows (via Windows Task Scheduler) and in cloud CI/CD environments (via GitHub Actions).

- **Low System Impact:** Configured with low CPU priority (`Priority 7` / Idle) so background execution never interrupts active development or foreground tasks.
- **Dependency Self-Healing:** Automatically bootstraps the required PowerShell `au` module from the PowerShell Gallery if not present.
- **Structured Logging & Rotation:** All execution logs are stored in `logs/` with rolling 14-day retention.
- **CI/CD Integration:** Integrates with GitHub Actions (`.github/workflows/choco-cron.yml`) to automatically check upstream releases, build updated packages, push them to chocolatey.org, and commit metadata updates back to Git.

---

## Usage

### Run Dry-Run Analysis (`WhatIf`):
```powershell
.\Invoke-PackageCron.ps1 -WhatIf
```

### Run Live Update Locally:
```powershell
.\Invoke-PackageCron.ps1
```

### Update a Specific Package:
```powershell
.\Invoke-PackageCron.ps1 -Name "vortex"
```

### Target an Alternate Directory:
```powershell
.\Invoke-PackageCron.ps1 -Root ".\stable"
```

### Register Local Windows Scheduled Task:
To run the updater automatically every Sunday at 3:00 AM:
```powershell
.\Invoke-PackageCron.ps1 -RegisterTask
```

---

## Package Structure

| Directory | Description | Status |
| :--- | :--- | :--- |
| `automatic/` | Packages with `update.ps1` managed automatically by AU | Active / Monitored |
| `stable/` | Production-ready package builds and historic revisions | Active |
| `manual/` | Packages requiring manual build interventions | As needed |
| `test/` | Experimental builds and package candidates | Testing |
| `deprecated/` | Retired packages preserved for historical reference | Archived |

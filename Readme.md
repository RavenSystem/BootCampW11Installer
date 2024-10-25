# Windows 11 Bootcamp Prepare Installer

A shell script to convert the Windows 11 ISO so Bootcamp will install it properly

## Description

This script is for getting around the `Bootcamp Stuck Downloading Support Software` and `Can’t install the software because it is not currently available from software update server` errors when trying to install Windows 11 via Bootcamp.

This simple shell script combines the Microsoft Windows 10 and Windows 11 ISO files into a single Windows 11 ISO file that can be installed by MacOS Bootcamp. Running this script will create a `Win11_BootCamp.iso` file on the Desktop. This file can then be given to Bootcamp to properly download the Apple Support Software and install Windows 11.

## Getting Started

### Prerequisites

* Windows 10 ISO file
* Windows 11 ISO file

### Executing program

#### Run with
```
sudo ./prepare_installer.sh [-help] <Windows 10 ES-ES ISO path> <Windows 11 ES-ES ISO path>
```
#### Windows Install Registry Edit Steps (Currently not needed)

After Bootcamp initiates the install, you will still need to disable TPM 2.0 by adding 3 registry keys.

1. When the "Install now" button shows, press "Shift+F10" to open a command prompt
2. Type "regedit" to open the registry
3. Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\Setup`
4. Add a new key named `LabConfig`
5. In LabConfig, add a new DWORD value named `BypassTPMCheck` and set it to 1
6. In LabConfig, add a new DWORD value named `BypassRAMCheck` and set it to 1
7. In LabConfig, add a new DWORD value named `BypassSecureBootCheck` and set it to 1
8. Exit the Registry and install Windows 11 as normal

## Authors

Script: [ZGreening](https://github.com/zgreening)

Largely borrowing code from an [article by John at TECHSVIEWER](https://techsviewer.com/how-to-install-windows-11-on-mac-with-boot-camp-assistant/)

## Version History

* 1.1
    * Add Windows Installation Registry Edit Steps For Reference
* 1.0
    * Initial Release

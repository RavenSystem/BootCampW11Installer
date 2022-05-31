# Windows 11 Bootcamp Prepare Installer

A shell script to convert the Windows 11 ISO so Bootcamp will install it properly

## Description

This is a simple shell script to combine the Microsoft Windows 10 and Windows 11 ISO files into a single Windows 11 ISO file that can be installed by MacOS Bootcamp.

Running this script will create a `Windows11.iso` file on the Desktop. This file can then be given to Bootcamp to properly download the Apple Support Software and install Windows 11.

## Getting Started

### Prerequisites

* Windows 10 ISO file
* Windows 11 ISO file

### Executing program

Run with
```
sudo ./prepare_installer.sh [-help] <Windows 10 ISO path> <Windows 11 ISO path>
```

## Authors

Script: [ZGreening](https://github.com/zgreening)

Largely borrowing code from an [article by John at TECHSVIEWER](https://techsviewer.com/how-to-install-windows-11-on-mac-with-boot-camp-assistant/)

## Version History

* 1.0
    * Initial Release

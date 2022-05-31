#!/bin/bash

# Set exit on failure.
set -e;

# Declare variables.
nc='\033[0m';
red='\033[31m';
green='\033[32m';

# Unix style help man.
print_help() 
{
    echo "";
    echo "NAME";
    echo "    prepare_installer.sh";
    echo "";
    echo "SYNOPSIS";
    echo "    prepare_installer [-help] <Windows 10 ISO path> <Windows 11 ISO path>";
    echo "";
    echo "DESCRIPTION";
    echo "    The prepare_installer script makes the Windows11 ISO appear as a Windows10 ISO for downloading the support software from Apple.";
    echo "";
    echo "EXIT STATUS";
    echo "    The prepare_installer script exits successfully with status 0 and >0 if an error is encountered.";
    echo "";
}

##### VALIDATE

# Check if number of parameters is 0, or greater than 2, or if -help was specified.
if [ $# -eq 0 ] || [ $# -gt 2 ] || grep -q "-help" <<<$* ; then
    print_help;
    exit 0;
fi

# Print starting message.
echo "STARTING PREPARE_INSTALLER";
echo "";

# Check root permission (needed for a write step).
if [ $EUID -ne 0 ]; then 
    echo -e "${red}Please run with sudo${nc}";
    exit 1;
fi

# Basic check for Windows 10 ISO.
if [ ! -f $1 ] || ! grep -q ".*Win10.*\.iso" <<<$1; then
    echo -e "${red}Unable to find Windows 10 ISO at path:${nc} ${green}$1${nc}";
    exit 1;
else 
    echo -e "Found Windows 10 ISO at path: ${green}$1${nc}"
fi

# Basic check for Windows 11 ISO.
if [ ! -f $2 ] || ! grep -q ".*Win11.*\.iso" <<<$2; then
    echo -e "${red}Unable to find Windows 11 ISO at path${nc}: ${green}$2${nc}";
    exit 1;
elif [ -z $2 ]; then
    echo -e "${red}Windows 11 ISO path must not be empty${nc}";
    exit 1;
else 
    echo -e "Found Windows 11 ISO at path: ${green}$2${nc}"
fi

##### EXECUTE

# Create a DMG Image File.
hdiutil create -o /tmp/Windows11.dmg -size 5500m -volname Windows11 -fs UDF;

# Mount DMG to your Mac.
hdiutil attach /tmp/Windows11.dmg -noverify -mountpoint /Volumes/Windows11;

# Mount Microsoft Windows 10 ISO with provided path in argument one.
hdiutil mount $1;

# Now copy all files except install.wim to Windows 11 volumes.
rsync -avh --progress --exclude=sources/install.wim /Volumes/CCCOMA_X64FRE_EN-US_DV9/ /Volumes/Windows11;

# Unmount Windows 10 ISO.
hdiutil detach /Volumes/CCCOMA_X64FRE_EN-US_DV9/;

# Mount Microsoft Windows 11 ISO with provided path in argument two.
hdiutil mount $2;

# Copy Install.wim to Windows 11 Volumes with sudo commands.
sudo cp /Volumes/CCCOMA_X64FRE_EN-US_DV9/sources/install.wim /Volumes/Windows11/sources/;

# Unmount Windows 11.ISO Disk Image.
hdiutil detach /Volumes/CCCOMA_X64FRE_EN-US_DV9/;

# Unmount Windows 11 Volumes.
hdiutil detach /volumes/Windows11;

# Convert Windows11.dmg to ISO.
hdiutil convert /tmp/Windows11.dmg -format UDTO -o ~/Desktop/Windows11.cdr;

# Move this image to your desktop.
mv ~/Desktop/Windows11.cdr ~/Desktop/Windows11.iso;

# Delete Windows11.dmg in Temporary folder.
rm /tmp/Windows11.dmg;

# Print completion message.
echo -e "Windows 11 ISO created at: ${green}$HOME/Desktop/Windows11.iso${nc}";
echo -e "${green}PREPARE_INSTALLER COMPLETED SUCCESSFULLY${nc}";

#!/bin/bash
#
# Zoom.us full uninstall script
#
# - Download this file locally
# - Run `chmod 755 ./zoom_us_uninstall.sh.sh`
# - Run `./zoom_us_uninstall.sh.sh`

echo Cleaning Zoom…

echo Killing all Zoom processes…
pkill -i zoom

echo Cleaning Application…
{
  rm -rfv /Applications/zoom.us.app
  rm -rfv ~/Applications/zoom.us.app
  sudo kextunload -b zoom.us.ZoomAudioDevice
  sudo rm -rfv /System/Library/Extensions/ZoomAudioDevice.kext
} &> /dev/null

echo Cleaning Application Cached Files…
{
    rm -rfv ~/Downloads/zoomusInstaller.pkg
    sudo rm -rf /Applications/zoom.us.app
    rm -rf ~/Desktop/Zoom
    rm -rf "~/Library/Application Support/zoom.us"
    rm -rf ~/Library/Caches/us.zoom.xos
    rm -rf "~/Library/Internet Plug-Ins/ZoomUsPlugIn.plugin"
    rm -rf ~/Library/Logs/zoom.us
    rm -rf ~/Library/Logs/zoominstall.log
    rm -rf ~/Library/Preferences/ZoomChat.plist
    rm -rf ~/Library/Preferences/us.zoom.xos.plist
    rm -rf "~/Library/Saved Application State/us.zoom.xos.savedState"
} &> /dev/null

rm -rf ~/.zoomus
touch ~/.zoomus
chmod 000 ~/.zoomus

echo Done removing Zoom.

#!/bin/sh

# Remove MDM profile
sudo profiles -D

# rm Electric Apps
sudo rm -rf "/Applications/Electric.app" 
sudo rm -rf "/Applications/Electric | Self Service.app"

# Disable Jamf
sudo jamf removeFramework

# Uninstall connectwise
sudo rm -r /opt/connectwisecontrol*
sudo rm -r /Library/LaunchDaemons/connectwisecontrol*
sudo rm -r /Library/LaunchAgents/connectwisecontrol*
sudo rm -r /opt/screenconnect*
sudo rm -r /Library/LaunchDaemons/screenconnect*
sudo rm -r /Library/LaunchAgents/screenconnect*

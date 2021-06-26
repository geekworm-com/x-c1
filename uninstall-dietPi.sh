#!/bin/bash

#remove x-c1 old installtion

sudo systemctl disable pigpiod

sudo rm /etc/profile.d/naspi.sh -f
sudo rm /etc/x-c1-pwr.sh -f
sudo rm /usr/local/bin/x-c1-softsd.sh -f

echo "The uninstallation is complete."
echo "Please run 'sudo reboot' to reboot the device."

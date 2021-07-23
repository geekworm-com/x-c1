#!/bin/bash

#remove x-c1 old installtion

sudo sed -i '/x-c1/d' /etc/rc.local
sudo sed -i '/x-c1/d' ~/.bashrc

sudo rm /usr/local/bin/x-c1-softsd.sh -f
sudo rm /etc/x-c1-pwr.sh -f

sudo systemctl disable pigpiod

echo "The uninstallation is complete."
echo "Please run 'sudo reboot' to reboot the device."

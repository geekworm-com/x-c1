#!/bin/bash

#remove x-c1 old installtion

sudo systemctl stop pigpiod
sudo systemctl disable pigpiod

sudo systemctl stop rc.local
sudo systemctl disable rc.local

sudo rm /lib/systemd/system/pigpiod.service -f
sudo rm /lib/systemd/system/rc.local.service -f

#sudo rm /etc/profile.d/naspi.sh -f
sudo rm /etc/rc.local
sudo sed -i '/x-c1/d' ~/.bashrc

sudo rm /usr/local/bin/x-c1-softsd.sh -f
sudo rm /etc/x-c1pwr.sh -f

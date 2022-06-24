#!/bin/bash

#remove x-c1 old installtion

sudo systemctl stop pigpiod
sudo systemctl disable pigpiod

sudo systemctl stop x-c1-pwr
sudo systemctl stop x-c1-fan
sudo systemctl disable x-c1-pwr
sudo systemctl disable x-c1-fan

sudo rm /lib/systemd/system/pigpiod.service -f
sudo rm /lib/systemd/system/x-c1-pwr.service -f
sudo rm /lib/systemd/system/x-c1-fan.service -f

#sudo rm /etc/profile.d/naspi.sh -f
sudo sed -i '/x-c1/d' ~/.bashrc

sudo rm /usr/local/bin/x-c1-softsd.sh -f
sudo rm /usr/local/bin/fan.py -f
sudo rm /etc/x-c1pwr.sh -f

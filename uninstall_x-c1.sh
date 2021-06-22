#!/bin/bash
#remove x-c1 old installtion
sudo sed -i '/x-c1/d' /etc/rc.local
sudo sed -i '/xoff/d' ~/.bashrc

sudo rm /usr/local/bin/x-c1softsd.sh -f
sudo rm /etc/x-c1pwr.sh -f

sudo systemctl disable pigpiod

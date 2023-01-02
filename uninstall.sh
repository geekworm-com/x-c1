#!/bin/bash
#remove x-c1 old installtion
sudo sed -i '/x-c1/d' /etc/rc.local
sudo sed -i '/pigpiod/d' /etc/rc.local

sudo sed -i '/x-c1/d' ~/.bashrc

sed -i 's/ -n 127.0.0.1//' /lib/systemd/system/pigpiod.service

sudo rm /usr/local/bin/x-c1-softsd.sh -f
sudo rm /etc/x-c1-pwr.sh -f

sudo systemctl disable pigpiod

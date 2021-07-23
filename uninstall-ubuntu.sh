#!/bin/bash

#remove x-c1 old installtion
#SYS_RUN_FILE=/etc/bash.bashrc
#sudo sed -i '/pigpiod/d' ${SYS_RUN_FILE}


sudo systemd stop pigpiod
sudo systemd disable pigpiod

sudo rm /lib/systemd/system/pigpiod.service -f
#sudo rm /etc/profile.d/naspi.sh -f

sudo sed -i '/x-c1/d' /etc/rc.local
sudo sed -i '/x-c1/d' ~/.bashrc

sudo rm /usr/local/bin/x-c1-softsd.sh -f
sudo rm /etc/x-c1-pwr.sh -f

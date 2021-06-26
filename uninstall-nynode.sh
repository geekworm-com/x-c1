#!/bin/bash

#remove x-c1 old installtion
#SYS_RUN_FILE=/etc/bash.bashrc
#sudo sed -i '/pigpiod/d' ${SYS_RUN_FILE}
#sudo sed -i '/x-c1/d' ${SYS_RUN_FILE}

sudo systemd stop pigpiod
sudo systemd disable pigpiod

sudo rm /etc/profile.d/naspi.sh -f

sudo rm /usr/local/bin/x-c1-softsd.sh -f
sudo rm /etc/x-c1pwr.sh -f

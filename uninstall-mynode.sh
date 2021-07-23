#!/bin/bash

#remove x-c1 old installtion
AUTO_RUN=/etc/rc.local
sudo sed -i '/naspi/d' ${AUTO_RUN}

sudo sed -i '/pigpiod/d' ${AUTO_RUN}
sudo sed -i '/x-c1/d' ${AUTO_RUN}
sudo sed -i '/python/d' ${AUTO_RUN}

sudo sed -i '/x-c1/d' ~/.bashrc

sudo systemctl stop pigpiod
sudo systemctl disable pigpiod

sudo rm /etc/naspi.sh -f
sudo rm /etc/x-c1-pwr.sh -f
sudo rm /usr/local/bin/x-c1-softsd.sh -f

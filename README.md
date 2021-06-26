User Guide: https://wiki.geekworm.com/X-C1_Software

## For Raspbian or RetroPie OS
Test this script based on RetroPie 4.7.1 and Raspbian 2021-05-07-raspios-buster-armhf
> install
```
cd ~
sudo apt-get update
sudo apt-get install -y python-smbus
sudo apt-get install -y pigpio python-pigpio python3-pigpio
git clone https://github.com/geekworm-com/x-c1
cd x-c1
sudo chmod +x *.sh
sudo bash install.sh
sudo reboot
```
> PWM fan control
```
The script is installed successfully and the fan starts to run
```
> Test safe shutdown
```
xoff
```
- xoff is safe shutdown command
- press button `1-2` seconds to reboot
- press button `3` seconds to safe shutdown,
- press `7-8` seconds to force shutdown.

> uninstall
```
sudo ./uninstall.sh
```

## For ubuntu mate OS (test on ubuntu-mate-20.04.1-desktop)
Test this script based on ubuntu-mate-20.04.1-desktop and ubuntu server 21.04
> install
```
cd ~
sudo apt update
sudo apt upgrade  #DON'T forget this step, or 'sudo pigpiod' is failed.
sudo apt install -y unzip make gcc python git
sudo apt install python-setuptools

#install pigpio library, also refer to http://abyz.me.uk/rpi/pigpio/download.html
wget https://github.com/joan2937/pigpio/archive/master.zip
unzip master.zip
cd pigpio-master
sudo make
sudo make install

sudo apt install -y python-pigpio python3-pigpio

cd ~
git clone https://github.com/geekworm-com/x-c1
cd x-c1
sudo chmod +x *.sh
sudo bash install-ubuntu.sh
sudo reboot
```
> uninstall
```
sudo ./uninstall-ubuntu.sh
```
## For myNode
 About myNode refer to http://mynodebtc.com/
> Install

login to mynode teminal via Putty or Xsheel tool, the default user name is `admin`, password is `bolt`, then run the following command:
```
 sudo apt-get update
 sudo apt-get install python-smbus
 sudo apt-get install pigpio python-pigpio
 git clone https://github.com/geekworm-com/x-c1
 cd x-c1
 chmod +x *.sh
 sudo bash install-mynode.sh
```
> uninstall
```
sudo ./uninstall-mynode.sh
```
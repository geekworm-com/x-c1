User Guide: https://wiki.geekworm.com/X-C1_Software

## For raspbian OS
> install
```
cd ~
sudo apt-get update
sudo apt-get install python-smbus
sudo apt-get install pigpio python-pigpio python3-pigpio
git clone https://github.com/geekworm-com/x-c1
cd x-c1
sudo chmod +x *.sh
sudo bash x-c1.sh
sudo reboot
```
> Test safe shutdown
```
xoff
xoff is safe shutdown command
press button 1-2 seconds to reboot
press button 3 seconds to safe shutdown,
press 7-8 seconds to force shutdown.
```

> uninstall
```
sudo ./uninstall.sh
```

## For ubuntu mate OS (test on ubuntu-mate-20.04.1-desktop)
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
sudo bash ubuntu-mate.sh
sudo reboot
```
> uninstall
```
sudo ./uninstall_ubuntu.sh
```

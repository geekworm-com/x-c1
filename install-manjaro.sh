#IMPORTANT! This script is only for the x-c1
#x-c1 Powering on /reboot /full shutdown through hardware
#!/bin/bash

echo '#!/bin/bash

REBOOTPULSEMINIMUM=200
REBOOTPULSEMAXIMUM=600

SHUTDOWN=4
if [ ! -d /sys/class/gpio/gpio$SHUTDOWN ]
then
  echo "$SHUTDOWN" > /sys/class/gpio/export
  sleep 1 ;# Short delay while GPIO permissions are set up
  echo "in" > /sys/class/gpio/gpio$SHUTDOWN/direction
fi
BOOT=17
if [ ! -d /sys/class/gpio/gpio$BOOT ]
then
  echo "$BOOT" > /sys/class/gpio/export
  sleep 1 ;# Short delay while GPIO permissions are set up
  echo "out" > /sys/class/gpio/gpio$BOOT/direction
  echo "1" > /sys/class/gpio/gpio$BOOT/value
fi

echo "Watching gpio for changes, to clean shutdown/reboot..."

while [ 1 ]; do
  shutdownSignal=$(cat /sys/class/gpio/gpio$SHUTDOWN/value)
  if [ $shutdownSignal = 0 ]; then
    /bin/sleep 0.2
  else
    pulseStart=$(date +%s%N | cut -b1-13)
    while [ $shutdownSignal = 1 ]; do
      /bin/sleep 0.02
      if [ $(($(date +%s%N | cut -b1-13)-$pulseStart)) -gt $REBOOTPULSEMAXIMUM ]; then
        echo "Your device are shutting down", SHUTDOWN, ", halting Rpi ..."
        sudo poweroff
        exit
      fi
      shutdownSignal=$(cat /sys/class/gpio/gpio$SHUTDOWN/value)
    done
    if [ $(($(date +%s%N | cut -b1-13)-$pulseStart)) -gt $REBOOTPULSEMINIMUM ]; then
      echo "Your device are rebooting", SHUTDOWN, ", recycling Rpi ..."
      sudo reboot
      exit
    fi
  fi
done' > /etc/x-c1-pwr.sh
sudo chmod +x /etc/x-c1-pwr.sh
#sudo sed -i '$ i /etc/x-c1-pwr.sh &' ${AUTO_RUN}

#x-c1 full shutdown through shell
echo '#!/bin/bash

BUTTON=27

echo "$BUTTON" > /sys/class/gpio/export;
echo "out" > /sys/class/gpio/gpio$BUTTON/direction
echo "1" > /sys/class/gpio/gpio$BUTTON/value

SLEEP=${1:-4}

re='^[0-9\.]+$'
if ! [[ $SLEEP =~ $re ]] ; then
   echo "error: sleep time not a number" >&2; exit 1
fi

echo "Your device will shutting down in 4 seconds..."
/bin/sleep $SLEEP

echo "0" > /sys/class/gpio/gpio$BUTTON/value
' > /usr/local/bin/x-c1-softsd.sh
sudo chmod +x /usr/local/bin/x-c1-softsd.sh

# create pigpiog service - begin
SERVICE_NAME="/lib/systemd/system/pigpiod.service"
if [ -e $SERVICE_NAME ]; then
	sudo rm $SERVICE_NAME -f
fi

sudo echo '[Unit]
Description=Daemon required to control GPIO pins via pigpio

[Service]
ExecStart=/usr/local/bin/pigpiod -l
ExecStop=/bin/systemctl kill pigpiod
Type=forking

[Install]
WantedBy=multi-user.target
' >> ${SERVICE_NAME}

CUR_DIR=$(pwd)

#####################################

cp ${CUR_DIR}/x-c1-fan.service /lib/systemd/system/
cp ${CUR_DIR}/x-c1-pwr.service /lib/systemd/system/

sudo systemctl enable pigpiod
sudo systemctl enable x-c1-fan
sudo systemctl enable x-c1-pwr

#auto run naspi.sh
sudo pigpiod
/usr/local/bin/fan.py &

echo "The installation is complete."
echo "Please run 'sudo reboot' to reboot the device."
echo "NOTE:"
echo "1. /usr/local/bin/fan.py is python file to control fan speed according temperature of CPU, you can modify it according your needs."
echo "2. PWM fan needs a PWM signal to start working. If fan doesn't work in third-party OS afer reboot only remove the YELLOW wire of fan to let the fan run immediately or contact us: info@geekworm.com."

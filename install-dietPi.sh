#IMPORTANT! This script is only for the x-c1
#x-c1 Powering on /reboot /full shutdown through hardware
#!/bin/bash
echo '#!/bin/bash

SHUTDOWN=4
REBOOTPULSEMINIMUM=200
REBOOTPULSEMAXIMUM=600
echo "$SHUTDOWN" > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio$SHUTDOWN/direction
BOOT=17
echo "$BOOT" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$BOOT/direction
echo "1" > /sys/class/gpio/gpio$BOOT/value

echo "Power management script is running..."

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

#x-c1 full shutdown through Software
#!/bin/bash

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

sudo systemctl enable pigpiod

# save these shell to naspi.sh
SHELL_FILE=/etc/profile.d/naspi.sh

sudo echo "/etc/x-c1-pwr.sh &" > ${SHELL_FILE}
sudo echo "alias xoff='sudo x-c1-softsd.sh'" >> ${SHELL_FILE}
#sudo echo "sudo pigpiod" >> ${SHELL_FILE}
sudo echo "python $(pwd)/fan.py&" >> ${SHELL_FILE}

#auto run naspi.sh
sudo chmod +x ${SHELL_FILE}
.${SHELL_FILE}

# manual run
sudo pigpiod
python $(pwd)/fan.py&

echo "The installation is complete."
echo "Please run 'sudo reboot' to reboot the device."
echo "NOTE:"
echo "1. DON'T modify the name fold: $(basename $(pwd)), or the PWM fan will not work after reboot."
echo "2. fan.py is python file to control fan speed according temperature of CPU, you can modify it according your needs."
echo "3. PWM fan needs a PWM signal to start working. If fan doesn't work in third-party OS afer reboot only remove the YELLOW wire of fan to let the fan run immediately or contact us: info@geekworm.com."

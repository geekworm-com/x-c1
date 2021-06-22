This shell script and python file is tested only on Raspberry pi OS..

Guide: https://wiki.geekworm.com/X-C1_Software

## x-c1.sh
setup scripts for x-c1 adapter shield to get safe shutdown.

## User manual

>git clone https://github.com/geekworm-com/x-c1

>cd x-c1

>sudo chmod +x x-c1.sh

>sudo bash x-c1.sh

>sudo reboot

Test safe shutdown

>xoff

>#xoff is safe shutdown command, you can press button 3 seconds to safe shutdown, or long press 7-8 seconds to force shutdown.

At this time, the fan is still not rotating, we need to continue to install the pwm fan control script,We can manually run the following commands:

>sudo python /home/pi/x-c1/x-c1_pwm_fan_control.py&

But we hope that the script can be executed automatically when the Raspberry Pi board boots, we can use crontab system command to achieve it. please refer to the following:

>pi@raspberrypi ~ $  `sudo crontab -e`

 Choose "`1`" then press Enter

 Add a line at the end of the file that reads like this:

>`@reboot python /home/pi/x-c1/x-c1_pwm_fan_control.py`

## uninstall_x-c1.sh
uninsatll x-c1 shell script, run the following command:
> sudo ./uninstall_x-c1.sh

## How to software turn off pi 4
> xoff  # type this command will execute software shut down.



#!/usr/bin/python
import pigpio
import time

servo = 18

pwm = pigpio.pi()
pwm.set_mode(servo, pigpio.OUTPUT)
pwm.set_PWM_frequency( servo, 25000 )
pwm.set_PWM_range(servo, 100)
fan = 0
while(1):
     #get CPU temp
     file = open("/sys/class/thermal/thermal_zone0/temp")
     temp = float(file.read()) / 1000.00
     temp = float('%.2f' % temp)
     file.close()
     if(temp > 30):
          pwm.set_PWM_dutycycle(servo, 40)
          newfan = 40

     if(temp > 50):
          pwm.set_PWM_dutycycle(servo, 50)
          newfan = 50

     if(temp > 60):
          pwm.set_PWM_dutycycle(servo, 70)
          newfan = 70

     if(temp > 70):
          pwm.set_PWM_dutycycle(servo, 80)
          newfan = 80

     if(temp > 75):
          pwm.set_PWM_dutycycle(servo, 100)
          newfan = 100

     if(temp < 30):
          pwm.set_PWM_dutycycle(servo, 0)
          newfan = 0
     if (newfan != fan):
          fan = newfan
          print("fan set to " + str(fan), flush=True)
     time.sleep(1)

import sys
from time import sleep, time
import RPi.GPIO as gpio
from subprocess import call
 
gpio.setmode(gpio.BOARD)
poweroff_delay = 10
check_delay = 0.85
pir_pin = 11
 
def main():
    gpio.setup(pir_pin, gpio.IN)
    isDisabled = False
    last_motion_time = time()
 
    while True:
        if gpio.input(pir_pin):
            last_motion_time = time()
            sys.stdout.flush()
            if isDisabled:
                isDisabled = False
                call('sudo vcgencmd display_power 1', shell=True)
        else:
            if time() > (last_motion_time + poweroff_delay) and not isDisabled:
                    isDisabled = True
                    call('sudo vcgencmd display_power 0', shell=True)
        sleep(check_delay)
 
if __name__ == '__main__':
    subprocess.call('sudo vcgencmd display_power 1', shell=True)
    main()

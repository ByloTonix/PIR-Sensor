import sys
import time
import RPi.GPIO as gpio
import subprocess
 
gpio.setmode(gpio.BOARD)
poweroff_delay = 10
check_delay = 0.1
pir_pin = 11
 
def main():
    gpio.setup(pir_pin, gpio.IN)
    isDisabled = False
    last_motion_time = time.time()
 
    while True:
        if gpio.input(pir_pin) == 1:
            print('Датчик зафиксировал движение...')
            last_motion_time = time.time()
            sys.stdout.flush()
            if isDisabled == True:
                print('Попытка включения экрана...')
                isDisabled = False
                turn_on()
            else:
                print('Экран был включен, ничего не меняю')
                pass
        else:
            if time.time() > (last_motion_time + poweroff_delay):
                print('Наступил момент выключения экрана. Попытка выключения...')
                if isDisabled == False:
                    isDisabled = True
                    turn_off()
                else:
                    print('Экран был выключен, ничего не меняю')
            else:
                print('Время ещё не настало, осталось ', (last_motion_time + poweroff_delay) - time.time())
                pass
        time.sleep(check_delay)
 
def turn_on():
    subprocess.call('sudo vcgencmd display_power 1', shell=True)
    print('Экран включен')
    
def turn_off():
    subprocess.call('sudo vcgencmd display_power 0', shell=True)
    print('Экран выключен')
 
if __name__ == '__main__':
    turn_on()
    main()

<h1 align="center">Raspberry Pi Motion Detector</h1>
<h4 align="center">Raspberry Pi Motion Detector is a Python script with which you can use Raspberry Pi and a PIR sensor as a motion detector.</h4>

## Warnings:
- Make sure you are using **Raspberry Pi OS Bullseye**. Other versions of Raspberry Pi OS or other Linux distributions have not been **tested** and are **not supported**.

## Requirements:
- Raspberry Pi
- Any three-pin PIR sensor

## Setup:
- In the file pir.py edit poweroff_delay and check_delay to change the screen auto-off time and the delay between sensor polling, as well as pir_pin to the one you use for the sensor (BOARD type numbering)
```sh
gpio.setmode(gpio.BOARD)
poweroff_delay = 10
check_delay = 0.85
pir_pin = 11
```
- Download the script:
```sh
git clone https://github.com/ByloTonix/PIR-Sensor/
cd PIR-Sensor/
```

## Usage:
- After completing the configuration, go to the directory with the script and run it:
```sh
cd ~/PIR-Sensor
sudo python3 pir.py
```

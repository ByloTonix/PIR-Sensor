#!/bin/bash
if [ "${UID}" != "0" ]; then
  echo "You must be root to start the installation"
  exit 1
fi


echo "Starting Process"
echo "Updating Repositories"
sleep 1
apt update -y
wait
apt upgrade -y
wait

echo "Install needed packages"
sudo apt install unclutter -y

echo "Backuping config.txt"
cp /boot/config.txt /boot/config.txt.bak
echo "Modifying config.txt"
sed -i 's/dtoverlay=vc4-fkms-v3d/dtoverlay=vc4-kms-v3d/' /boot/config.txt
sh -c 'echo "over_voltage=6" >> //boot/config.txt'
sh -c 'echo "arm_freq=2100" >> //boot/config.txt'
sh -c 'echo "gpu_freq=750" >> //boot/config.txt'
sh -c 'echo "gpu_mem=256" >> //boot/config.txt'

echo "Autostart"
sh -c 'echo "@xset s noblank" >> /etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@xset s off" >> /etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@xset -dpms" >> /etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@unclutter -idle 0.5 -root &" >> /etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences" >> /etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences" >> /etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@chromium-browser --noerrdialogs --disable-infobars --kiosk https://www.ya.ru &" >> /etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@python3 /home/vova/PIR-Sensor/pir.py &" >> /etc/xdg/lxsession/LXDE-pi/autostart'

echo "Done"

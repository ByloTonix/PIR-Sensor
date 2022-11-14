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

echo "Installing needed packages"
apt install unclutter -y
apt install ffmpeg libmariadb3 libpq5 libmicrohttpd12 -y

echo "Installing MotionEye "
wget https://github.com/Motion-Project/motion/releases/download/release-4.3.2/pi_buster_motion_4.3.2-1_armhf.deb 
dpkg -i pi_buster_motion_4.3.2-1_armhf.deb
systemctl stop motion
systemctl disable motion
apt install python2 python-dev-is-python2 -y
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
python2 get-pip.py
apt install libssl-dev libcurl4-openssl-dev libjpeg-dev zlib1g-dev -y
pip2 install motioneye
mkdir -p /etc/motioneye
cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf
mkdir -p /var/lib/motioneye
cp /usr/local/share/motioneye/extra/motioneye.systemd-unit-local /etc/systemd/system/motioneye.service
systemctl daemon-reload
systemctl enable motioneye
systemctl start motioneye

echo "Backuping config.txt"
cp /boot/config.txt /boot/config.txt.bak

echo "Modifying config.txt"
sed -i 's/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-fkms-v3d/' /boot/config.txt
sed -i 's/arm_boost=1/# arm_boost=1/' /boot/config.txt
sh -c 'echo "over_voltage=6" >> //boot/config.txt'
sh -c 'echo "arm_freq=2100" >> //boot/config.txt'
sh -c 'echo "gpu_freq=750" >> //boot/config.txt'
sh -c 'echo "gpu_mem=256" >> //boot/config.txt'

echo "Backuping autostart config file"
cp /etc/xdg/lxsession/LXDE-pi/autostart /etc/xdg/lxsession/LXDE-pi/autostart.bak

echo "Modifying autostart config file"
sh -c 'echo "@xset s noblank" >> //etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@xset s off" >> //etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@xset -dpms" >> //etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@unclutter -idle 0.5 -root &" >> //etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences" >> //etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences" >> //etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@chromium-browser --noerrdialogs --disable-infobars --kiosk https://www.ya.ru &" >> //etc/xdg/lxsession/LXDE-pi/autostart'
sh -c 'echo "@python3 /home/vova/PIR-Sensor/pir.py &" >> //etc/xdg/lxsession/LXDE-pi/autostart'

echo "Done"

<h1 align="center">Raspberry Pi Motion Detector</h1>
<h4 align="center">Raspberry Pi Motion Detector - это Python-скрипт, с помощью которого можно использовать Raspberry Pi и PIR-датчик для неё в качестве детектора движения.</h4>

## Предупреждения:
- Убедитесь, что вы используете **Raspberry Pi OS Bullseye**. Возможна работа на Raspberry Pi OS Legacy при использовании ядра Linux определённой версии. Другие дистрибутивы не проверялись,
- Убедитесь, что у вас установлен **Python 3.x**.

## Требования:
- Raspberry Pi
- Любой трёхконтактный PIR-датчик

## Настройка:

- В файле pir.py отредактируйте poweroff_delay и check_delay для изменения времени автоматического выключения экрана и задержку между опросом датчика, а также pir_pin на тот, который вы используете для датчика (нумерация типа BOARD)
```sh
gpio.setmode(gpio.BOARD)
poweroff_delay = 10
check_delay = 0.85
pir_pin = 11
```


- Скачайте скрипт:
```sh
git clone https://github.com/MatroCholo/PIR-Sensor/
cd PIR-Sensor/
```

## Использование:
- После выполнения настройки перейдите в каталог со скриптом и запустите его:
```sh
cd ~/PIR-Sensor
sudo python3 pir.py
```

## Обратная связь:
- Telegram: https://t.me/MatroCholo

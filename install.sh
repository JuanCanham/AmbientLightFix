#!/usr/bin/env bash
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ -f "/sys/bus/iio/devices/iio:device0/in_illuminance_raw" ];
then
	echo "Default sensor found"
	echo 'To override set the "SENSOR_PATH" envvar in the unit file'
else
	echo "Default sensor not found"
	echo 'You must configure "SENSOR_PATH" envvar in the unit file'
fi

BACKLIGHT_PATH=$(dirname /sys/class/backlight/*/.)
if [ -d "$BACKLIGHT_PATH" ]
then
    echo "By default this will set $BACKLIGHT_PATH/brightness"
    echo 'to override set the "BACKLIGHT_PATH" envvar in the unit file'
else
    echo "Could not find any backlights"
    echo 'You must configure "BACKLIGHT_PATH" envvar in the unit file for this to work'
fi

cp "$SOURCE/ambientLightFix" /usr/local/bin/ambientLightFix
cp "$SOURCE/ambientLightFix.service" /etc/systemd/system/ambientLightFix.service
systemctl enable ambientLightFix.service

echo "Installed"
echo "To start the service run systemctl start ambientLightFix.service"

#!/usr/bin/env sh
systemctl stop ambientLightFix_gmux.service
systemctl disable ambientLightFix_gmux.service
rm /usr/local/bin/ambientLightFix
rm /etc/systemd/system/ambientLightFix.service
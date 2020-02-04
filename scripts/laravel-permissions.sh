#!/bin/bash
#

U=$(id -u -n) # <-- posix current user

echo ${U}

sudo chown -R ${U}:www-data ../
sudo find ../ -type d -exec chmod 2750 {} \+
sudo find ../ -type f -exec chmod 640 {} \+
sudo chmod -R ug+rwx storage bootstrap/cache vendor/bin/phpunit

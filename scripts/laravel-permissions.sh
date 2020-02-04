#!/bin/bash
#

U=$(id -u -n) # <-- posix current user

echo ${U}

chown -R ${U}:www-data ../
find ../ -type d -exec chmod 2750 {} \+
find ../ -type f -exec chmod 640 {} \+
chmod -R ug+rwx storage bootstrap/cache vendor/bin/phpunit

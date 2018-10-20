#!/bin/bash

cd ~/

DIRNAME=nextcloud-backup-$(date +%Y%m%d%H%M%S)

cd $DIRNAME

echo 'Taking backup of web root'
rsync -Aax /var/www/nextcloud/ nextcloud-dirbkp_`date +"%Y%m%d"`

echo 'Taking backup of database'
mysqldump --single-transaction -u oc_nc_admin_user -p nextcloud > nextcloud-sqlbkp_`date +"%Y%m%d"`.bak

cd ~/

tar czf $DIRNAME.tar.gz $DIRNAME

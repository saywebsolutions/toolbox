#!/bin/bash

sudo chgrp -R www-data /var/www
sudo chmod -R g+w /var/www
sudo find /var/www -type d -exec chmod 2775 {} \;
sudo find /var/www -type f -exec chmod ug+rw {} \;

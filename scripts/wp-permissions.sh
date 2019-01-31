#!/bin/bash
#
# http://codex.wordpress.org/Hardening_WordPress#File_permissions
#

WP_OWNER=$1 # <-- wordpress owner
WP_GROUP=$2 # <-- wordpress group
WP_DIR=$3 # <-- wordpress root directory
WS_GROUP=$2 # <-- webserver group

# baseline settings
find ${WP_DIR} -exec chown ${WP_OWNER}:${WP_GROUP} {} \;
find ${WP_DIR} -type d -exec chmod 755 {} \;
find ${WP_DIR} -type f -exec chmod 644 {} \;

# allow wordpress to manage wp-config.php but prevent world access
chgrp ${WS_GROUP} ${WP_DIR}/wp-config.php
chmod 660 ${WP_DIR}/wp-config.php

# allow wordpress to manage wp-content
find ${WP_DIR}/wp-content -exec chgrp ${WS_GROUP} {} \;
find ${WP_DIR}/wp-content -type d -exec chmod 775 {} \;
find ${WP_DIR}/wp-content -type f -exec chmod 664 {} \;

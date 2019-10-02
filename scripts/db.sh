#! /bin/bash

DB_NAME=""
DB_USER="${DB_NAME}_usr"
DB_PASS=""

SQL="DROP USER IF EXISTS ${DB_USER};CREATE DATABASE IF NOT EXISTS ${DB_NAME};USE ${DB_NAME};GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';FLUSH PRIVILEGES;"

echo "Executing: ${SQL}\n"

#set mysql password with env variable prior to running command: export MYSQL_PWD=
mysql -u root -ve "${SQL}"

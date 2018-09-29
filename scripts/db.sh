#! /bin/bash

DB_NAME=""
DB_USER="${DB_NAME}_usr"
DB_PASS=""

SQL="DROP USER IF EXISTS ${DB_USER};CREATE DATABASE IF NOT EXISTS ${DB_NAME};GRANT ALL ON ${DB_NAME} TO '${DB_USER}'@'*' IDENTIFIED BY '${DB_PASS}';FLUSH PRIVILEGES;"

echo "Executing: ${SQL}\n"

sudo mysql -u root -e "${SQL}"

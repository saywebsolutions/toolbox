#!/bin/bash
set -euo pipefail

########################
### SCRIPT VARIABLES ###
########################

apt-get update
apt-get -y upgrade
apt-get -y autoremove

apt install -y redis-server
sed --in-place 's/^supervised.*/supervised systemd/g' /etc/redis/redis.conf
systemctl restart redis

systemctl status redis

echo "ping" | redis-cli

echo "set test hai" | redis-cli

echo "get test" | redis-cli

systemctl restart redis

echo "get test" | redis-cli

#server by default should be bound to localhost only, so no need to adjust bind param
# bind 127.0.0.1 ::1

RPW=$(openssl rand 60 | openssl base64 -A)

echo ${RPW}

sed --in-place "s|# requirepass foobared|requirepass ${RPW}|g" /etc/redis/redis.conf

echo "get test" | redis-cli

systemctl restart redis

echo "set testpassword haipassword" | redis-cli -a ${RPW}

echo "get testpassword" | redis-cli -a ${RPW}

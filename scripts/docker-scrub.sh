#!/bin/bash

# Uninstall Script
if [[ `id -u` -ne 0 ]]; then
	echo "$0 must be root/sudo!"
	exit 2
fi

while true; do
  read -p "Remove all VMs? (Y/N): " yn
  case $yn in
    [Yy]* ) docker-machine rm -f $(docker-machine ls -q); break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

apt-get remove docker docker-engine docker.io containerd runc

echo "Removing Applications..."
rm -rf /Applications/Docker

apt-get purge -y docker-ce docker-ce-cli
apt-get autoremove -y --purge docker-ce docker-ce-cli
rm -rf /var/lib/docker /etc/docker
rm /etc/apparmor.d/docker
groupdel docker
rm -rf /var/run/docker.sock
ifconfig docker0 down
brctl delbr docker0

echo "Removing docker binaries..."
rm -f /usr/local/bin/docker
rm -f /usr/local/bin/docker-machine
rm -f /usr/local/bin/docker-compose

echo "Removing boot2docker.iso and socket files..."
rm -rf ~/.docker
rm -rf /usr/local/share/boot2docker

echo "All Done!"

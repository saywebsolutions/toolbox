#!/bin/sh

# DATA

USER="user"
SUDO_PASSWORD="pass"
MYSQL_ROOT_PASSWORD="pass"
SSH_PORT="22"

# SSH access via password will be disabled. Use keys instead.
PUBLIC_SSH_KEYS="# Home
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCku/zUMjyblDcz9QrEIzmAAHkYWN3YJJHHpG+e/K168mMbZeZFPRY882ne6fvBwdSn2EcsZA/soo/0kPksw8nsU1tHIuh62s6SNKh52VMLDnkeRJijwIqNXh6jF+Uf9IiJNOKt1TgJ6wAwtEfs8qdqNZgkScBT3My47MulrLRzf1c1CmUNLlgVAAOQ2x4HAPLMZBZ8fxA449jzijYCPAZhzXxoBnOB7iVcWlsohtRJiJpy0MVsW6MIqvpEJAfNZcUT0kLHv9yqCsH5qYjxQgkSBXk/YXfF0DeVk6qc13X0fJkL8DTUtltF+D11eYXEf7LZjjpXgUeZVHwpuudwdaCj kjones@kjones-desktop
"

TIMEZONE="America/Los_Angeles" # lits of avaiable timezones: ls -R --group-directories-first /usr/share/zoneinfo

# BEGIN

# Upgrade The Base Packages
apt update
apt upgrade -y

# Base Packages
apt-get install -y --force-yes curl gcc git make \
unzip whois htop

# Disable Password Authentication Over SSH
sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
sed -i -e '/^Port/s/^.*$/Port $SSH_PORT/' /etc/ssh/sshd_config

# Restart SSH
service ssh restart

# Set The Timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Create The Root SSH Directory If Necessary
if [ ! -d /root/.ssh ]
then
    mkdir -p /root/.ssh
    chmod 400 /root/.ssh
    touch /root/.ssh/authorized_keys
fi

# Setup User
useradd $USER -s /bin/bash -G sudo
mkdir -p /home/$USER/.ssh

# Setup Bash For User
cp /root/.profile /home/$USER/.profile
cp /root/.bashrc /home/$USER/.bashrc

# Set The Sudo Password For User
PASSWORD=$(mkpasswd $SUDO_PASSWORD)
usermod --password $PASSWORD $USER

# Build Formatted Keys & Copy Keys To User
#cat > /root/.ssh/authorized_keys << EOF
#$PUBLIC_SSH_KEYS
#EOF

cp /root/.ssh/authorized_keys /home/$USER/.ssh/authorized_keys
chown $USER /home/$USER/.ssh/authorized_keys

# Create The Server SSH Key
ssh-keygen -f /home/$USER/.ssh/id_rsa -t rsa -b 4096 -N ''

# Copy Github And Bitbucket Public Keys Into Known Hosts File
ssh-keyscan -H github.com >> /home/$USER/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> /home/$USER/.ssh/known_hosts
ssh-keyscan -H gitlab.com >> /home/$USER/.ssh/known_hosts

# Setup Site Directory Permissions
chown -R $USER:$USER /home/$USER
chmod -R 755 /home/$USER
chmod 600 /home/$USER/.ssh/id_rsa
chmod 400 /home/$USER/.ssh

# Setup Unattended Security Upgrades
cat > /etc/apt/apt.conf.d/50unattended-upgrades << EOF
Unattended-Upgrade::Allowed-Origins {
    "Ubuntu xenial-security";
};
Unattended-Upgrade::Package-Blacklist {
    //
};
EOF

cat > /etc/apt/apt.conf.d/10periodic << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

# Setup UFW Firewall

ufw allow 22
ufw allow 80
ufw allow 443
ufw --force enable

# Allow FPM Restart

echo "$USER ALL=NOPASSWD: /usr/sbin/service php7.0-fpm reload" > /etc/sudoers.d/php-fpm

# Configure Supervisor Autostart
systemctl enable supervisor.service
service supervisor start

# Configure Swap Disk
if [ -f /swapfile ]; then
    echo "Swap exists."
else
    fallocate -l $SWAP_SIZE /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile none swap sw 0 0" >> /etc/fstab
    echo "vm.swappiness=30" >> /etc/sysctl.conf
    echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf
fi

# Install Base PHP Packages
#apt-get install -y php7.0-cli php7.0 \
apt-get install -y php7.0-cli libapache2-mod-php7.0 \
php7.0-sqlite3 php7.0-gd \
php7.0-curl \
php7.0-mysql php7.0-mcrypt php7.0-mbstring \
php7.0-xml php7.0-zip php7.0-bcmath

# Install Composer Package Manager
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --filename=composer --install-dir=/usr/local/bin
php -r "unlink('composer-setup.php');"

# Misc. PHP CLI Configuration
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = \"America\/Los_Angeles\"/" /etc/php/7.0/cli/php.ini

# Configure Sessions Directory Permissions
chmod 733 /var/lib/php/sessions
chmod +t /var/lib/php/sessions

# Add User To www-data Group
usermod -a -G www-data $USER
id $USER
groups $USER

# Install Node.js
curl --silent --location https://deb.nodesource.com/setup_7.x | sudo -E bash
apt update
sudo apt-get install -y --force-yes nodejs

#npm install -g pm2
#npm install -g gulp

# Set The Automated Root Password
export DEBIAN_FRONTEND=noninteractive

# Install MySQL
#debconf-set-selections <<< "mysql-community-server mysql-community-server/data-dir select ''"
#debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password $MYSQL_ROOT_PASSWORD"
#debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password $MYSQL_ROOT_PASSWORD"

#TODO - add variable for which database to install

# Install mariadb
#export DEBIAN_FRONTEND=noninteractive
#sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password $MYSQL_ROOT_PASSWORD'
#sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD'
#sudo apt-get install -y mariadb-server

#apt install -y mariadb-server

# Configure Password Expiration
#echo "default_password_lifetime = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Configure Access Permissions For Root & User
#sed -i '/^bind-address/s/bind-address.*=.*/bind-address = */' /etc/mysql/mysql.conf.d/mysqld.cnf
#mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO root@'$SERVER_IP' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
#mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
#service mysql restart

#mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$USER'@'$SERVER_IP' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
#mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO '$USER'@'$SERVER_IP' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
#mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO '$USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
#mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

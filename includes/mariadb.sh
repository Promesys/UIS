#!/bin/bash

# Install MariaDB
echo "Installing MariaDB..."
echo ''
sudo apt-get install mariadb-server mariadb-client

sudo systemctl start mariadb
sudo systemctl enable mariadb

# Provide credentials for MariaDB
NEW_MYSQL_PASSWORD=`date +%s|sha256sum|base64|head -c 15`
CURRENT_MYSQL_PASSWORD=''

#
# Check is expect package installed
#
if [ $(dpkg-query -W -f='${Status}' expect 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    echo "Can't find expect. Trying install it..."
    sudo apt-get -y install expect
fi

SECURE_MYSQL=$(expect -c "
set timeout 3
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$CURRENT_MYSQL_PASSWORD\r\"
expect \"root password?\"
send \"y\r\"
expect \"New password:\"
send \"$NEW_MYSQL_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$NEW_MYSQL_PASSWORD\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "sudo ${SECURE_MYSQL}"

sudo apt-get -purge expect

# Save the MySQL root password in .my.cnf]
sudo echo "[client]
user=root
password=$ROOT_PASS" > /root/.my.cnf
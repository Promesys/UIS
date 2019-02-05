#!/bin/bash

# Install PHP
echo "Installing PHP..."
echo ''
# Install latest nginx version from community maintained ppa
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo add-apt-repository universe -y
sudo apt-get update
# Install PHP 7.3
apt install php7.3 php7.3-cli php7.3-common -y
apt install php7.3-fpm php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-mysql php7.3-zip php7.3-curl -y
update-alternatives --set php /usr/bin/php7.3
# Update PHP CLI configuration
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/cli/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/cli/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/cli/php.ini
sed -i "s/;date.timezone.*/date.timezone = Europe\/Amsterdam/" /etc/php/7.3/cli/php.ini
# Tweak PHP-FPM settings
sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" /etc/php/7.3/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = Off/" /etc/php/7.3/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/7.3/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 256M/" /etc/php/7.3/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = Europe\/Amsterdam/" /etc/php/7.3/fpm/php.ini
# Tune PHP-FPM pool settings
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/;request_terminate_timeout.*/request_terminate_timeout = 60/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/pm\.max_children.*/pm.max_children = 70/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/pm\.start_servers.*/pm.start_servers = 20/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/pm\.min_spare_servers.*/pm.min_spare_servers = 20/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/pm\.max_spare_servers.*/pm.max_spare_servers = 35/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/;pm\.max_requests.*/pm.max_requests = 500/" /etc/php/7.3/fpm/pool.d/www.conf

sudo systemctl restart nginx.service
sudo systemctl restart php7.3-fpm.service

#Remove PHP7.2 Packages
sudo apt-get purge `dpkg -l | grep php7.2| awk '{print $2}' |tr "\n" " "` -y

php -v
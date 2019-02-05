#!/bin/bash
theAction=$1
domainName=$2

theAction="create"
read -p "\e[31mPlease provide the domain name\e[39m: " domainName
directoryName="/var/www/$domainName"

if [ -z "$domainName" ]
	then
	echo -e "\e[31mPlease provide the domain name\e[39m"
	exit 
fi
if [ -z "$theAction" ]
	then
	echo -e "\e[31mAction not provided, it must be either create or delete\e[39m"
	exit
fi

if [ "$theAction" == "create" ]
	then

	if [ -d "$directoryName" ]
		then
		echo -e "\e[31mDirectory already exists. If not required, please delete first\e[39m"
		exit 
	fi
	sudo mkdir $directoryName
	sudo echo "<VirtualHost *:80>
	ServerName $domainName
	DocumentRoot \"$directoryName/\"
	<Directory \"$directoryName\">
		Options FollowSymLinks
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>" > /etc/nginx/sites-available/$domainName.conf
	sudo echo "<?php phpinfo();?>" > "$directoryName/phpinfo.php"
    ln -s /etc/nginx/sites-available/$domainName.conf /etc/nginx/sites-enabled/ &>/dev/null
	sudo chmod -R $directoryName &>/dev/null
	sudo chown -R www-data:www-data $directoryName &>/dev/null
	echo $directoryName
elif [ "$theAction" == "delete" ]
	then
	if [ -f "/etc/nginx/sites-enabled/$domainName.conf" ]
		then
		sudo a2dissite $domainName &>/dev/null
		sudo rm -r $directoryName
		sudo rm /etc/nginx/sites-available/$domainName.conf
		echo -e "\e[32mThe website $domainName deleted!\e[39m"
	else
		echo -e "\e[31mWe did not find vhost of $domainName\e[39m"
		exit
	fi
else
	echo -e "\e[31mThe action not recognized!\e[39m"
	exit
fi
sudo service nginx restart &>/dev/null
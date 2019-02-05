#!/bin/bash
theAction=$1
domainName=$2

theAction="create"
read -p "Please provide the domain name: " domainName
directoryName="/var/www/$domainName"

if [ -z "$theAction" ]
	then
	echo -e "Action not provided, it must be either create or delete."
	exit
fi

if [ "$theAction" == "create" ]
	then

	if [ -d "$directoryName" ]
		then
		echo -e "Directory already exists. If not required, please delete first."
		exit 
	fi
	sudo mkdir $directoryName
	sudo echo "server {
      listen          80;
      server_name     $domainName;
      root            /var/www/$domainName;
      index           index.php;
      try_files \$uri /index.php;
      location ~* \.php$ {
        fastcgi_pass    unix:/run/php/php7.3-fpm.sock;
        include         fastcgi.conf;
        fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
        fastcgi_index   index.php;
      }
    }" > /etc/nginx/sites-available/$domainName.conf
	sudo echo "<?php phpinfo();?>" > "$directoryName/phpinfo.php"
    ln -s /etc/nginx/sites-available/$domainName.conf /etc/nginx/sites-enabled/ &>/dev/null
	sudo chmod -R $directoryName &>/dev/null
	sudo chown -R www-data:www-data $directoryName &>/dev/null
	echo $directoryName
elif [ "$theAction" == "delete" ]
	then
	if [ -f "/etc/nginx/sites-enabled/$domainName.conf" ]
		then
		sudo rm /etc/nginx/sites-available/$domainName.conf
		echo -e "The website $domainName deleted!"
	else
		echo -e "We did not find vhost of $domainName"
		exit
	fi
else
	echo -e "The action not recognized!"
	exit
fi
sudo service nginx restart &>/dev/null
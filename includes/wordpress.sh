#!/bin/bash

# Install WordPress
echo "Installing WordPress..."
echo ''

read -p "Please provide the domain name: " domainName
directoryName="/var/www/$domainName"

if [ -d "$directoryName" ]
	then
    # Change directory to web root
    cd "/var/www/"
    # Download Wordpress
    wget http://wordpress.org/latest.tar.gz
    # Extract Wordpress
    tar -xzvf latest.tar.gz
    # Rename wordpress directory to domain name
    mv wordpress $domainName
    # Change directory to blog
    cd /var/www/$domainName/
    # Create a WordPress config file 
    mv wp-config-sample.php wp-config.php
    # Generate random password
    WP_PASSWORD=`date +%s|sha256sum|base64|head -c 15`
    #set database details with perl find and replace
    sed -i "s/$domainName/g" /var/www/$domainName/wp-config.php
    sed -i "s/$domainName/root/g" /var/www/$domainName/wp-config.php
    sed -i "s/$WP_PASSWORD/password/g" /var/www/$domainName/wp-config.php
    # Save the WP root password in .wp.cnf]
    sudo echo "[wordpress]
    user=$domainName
    password=$WP_PASSWORD" > /root/.wp.cnf
    #create uploads folder and set permissions
    mkdir wp-content/uploads
    chmod 777 wp-content/uploads
    #remove wp file
    rm /var/www/latest.tar.gz
    echo "Ready, go to http://$domainName and enter the blog info to finish the installation."
else
	echo -e "Domain doesn't exists. Please make one first."
	exit
fi
#!/bin/bash

showMenu(){
    echo ''
    echo -e "\e[32mWelcome to Ubuntu Installer Script automation bash script\e[39m"
    echo ''
    echo "----------------"
    echo " Please make your choice : "
    echo "----------------"
    echo "[1] Update"
    echo "[2] Set timezone"
    echo "[3] Enable automatic software updates"
    echo "[4] Install NGINX"
    echo "[5] Install PHP"
    echo "[6] Add VHOST"
    echo "[7] Install MariaDB"
    echo "[8] Exit"
    echo "----------------"
    read -p "Please Select A Number: " mc
    return $mc
}

# Check if is root or not
if [ "$EUID" -ne 0 ]
  then
  	echo -e "\e[31mError! You must run this as root user\e[39m"
  exit
fi

# Install sudo if missing
if ! hash sudo 2>/dev/null; then
	apt-get update -y &>/dev/null
	apt-get install sudo
	exit
fi

echo 'Checking OS compatibility'
echo ''

cmd="lsb_release -d"
output=$(eval $cmd 2>&1)
os=${output//[[:blank:]]/}
os=${os#*:}
bitversion=$(eval "getconf LONG_BIT")

# Define an array of supported OS
allowedOS=("Ubuntu16.04.1LTS" "Ubuntu18.04.1LTS")

# Check if it supports the OS then proceed
# else exit

if [[ " ${allowedOS[@]} " =~ " ${os} " ]]; then
    while [[ "$m" != "8" ]]
    do
        if [[ "$m" == "1" ]]; then
            echo "--------------"
            echo "Run an update and upgrade for packages."
            echo "--------------"
            ./includes/update.sh
        elif [[ "$m" == "2" ]]; then
            echo "--------------"
            echo "Set timezone to Europe/Amsterdam."
            echo "--------------"
            ./includes/timezone.sh
        elif [[ "$m" == "3" ]]; then
            echo "--------------"
            echo "Enable automatic software updates."
            echo "--------------"
            ./includes/autoupdate.sh
        elif [[ "$m" == "4" ]]; then
            echo "--------------"
            echo "Install NGINX."
            echo "--------------"
            ./includes/nginx.sh
        elif [[ "$m" == "5" ]]; then
            echo "--------------"
            echo "Install PHP."
            echo "--------------"
            ./includes/php.sh
        elif [[ "$m" == "6" ]]; then
            echo "--------------"
            echo "Add vhost."
            echo "--------------"
            ./includes/vhost.sh
        elif [[ "$m" == "7" ]]; then
            echo "--------------"
            echo "Install MariaDB."
            echo "--------------"
            ./includes/mariadb.sh
        fi
        showMenu
        m=$?
    done
    exit 0;
else
	echo -e "\e[31mIncompatible operating system detected. Only selected releases of Ubuntu are supported\e[39m"
fi
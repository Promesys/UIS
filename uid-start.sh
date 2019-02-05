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
    echo "[3] Exit"
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
    while [[ "$m" != "3" ]]
    do
        if [[ "$m" == "1" ]]; then
            echo "--------------"
            echo "Run an update and upgrade for packages."
            echo "--------------"
            sh ./includes/update.sh
            break
            ;;
        elif [[ "$m" == "2" ]]; then
            echo "--------------"
            echo "Set timezone to Europe/Amsterdam."
            echo "--------------"
            sh ./includes/timezone.sh
            break
            ;;
        fi
        showMenu
        m=$?
    done
    exit 0;
else
	echo -e "\e[31mIncompatible operating system detected. Only selected releases of Ubuntu are supported\e[39m"
fi
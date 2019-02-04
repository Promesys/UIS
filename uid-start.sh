#!/bin/bash
echo ''
echo -e "\e[32mWelcome to Ubuntu Installer Script automation bash script\e[39m"
echo ''

sleep 3

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
    PS3="Please make your choice : "
    
    # set shuttle list
    select choice in update endeavour
    do
        case $choice in
            update)
                echo "--------------"
                echo "Run an update and upgrade for packages."
                echo "--------------"
                sh ./includes/update.sh
                ;;
            endeavour)
                echo "--------------"		
                echo "Space Shuttle Endeavour is one of three currently operational orbiters in the Space Shuttle." 
                echo "--------------"		
                ;;
            *)		
                echo "Error: Please try again (select 1..7)!"
                ;;		
        esac
    done
else
	echo -e "\e[31mIncompatible operating system detected. Only selected releases of Ubuntu are supported\e[39m"
fi
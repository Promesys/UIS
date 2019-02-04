#!/bin/bash		
        
# Set timezone
echo "Setting timezone..."
echo ''
sudo dpkg-reconfigure tzdata
echo "Installing NTP time servers..."
echo ''
sudo apt-get install ntp -y  &>/dev/null
exit 0
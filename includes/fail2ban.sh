#!/bin/bash

# Install Fail2ban
echo "Installing Fail2ban..."
echo ''
apt-get install fail2ban
systemctl start fail2ban
systemctl enable fail2ban
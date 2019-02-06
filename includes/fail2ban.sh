#!/bin/bash

# Install Fail2ban
echo "Installing Fail2ban..."
echo ''
apt-get install fail2ban -y
systemctl start fail2ban
systemctl enable fail2ban
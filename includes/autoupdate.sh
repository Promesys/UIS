#!/bin/bash

# Enable auto upgrades
echo "Enabling automatic software updates..."
echo ''
sudo apt-get install -y unattended-upgrades
sudo dpkg-reconfigure -p critical unattended-upgrades
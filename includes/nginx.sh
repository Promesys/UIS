#!/bin/bash

# Install NGINX
echo "Installing NGINX..."
echo ''
sudo apt update
sudo apt install nginx
sudo systemctl status nginx
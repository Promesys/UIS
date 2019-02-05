#!/bin/bash

# Install NGINX
echo "Installing NGINX..."
echo ''
# Install software-properties-common package to give us add-apt-repository package
sudo apt-get install -y software-properties-common
# Install latest nginx version from community maintained ppa
sudo add-apt-repository ppa:nginx/stable
# Update packages after adding ppa
sudo apt-get update
# Install nginx
sudo apt-get install -y nginx
# Tweak Nginx settings
sed -i "s/worker_processes.*/worker_processes auto;/" /etc/nginx/nginx.conf
sed -i "s/# multi_accept.*/multi_accept on;/" /etc/nginx/nginx.conf
sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 128;/" /etc/nginx/nginx.conf
sed -i "s/# server_tokens off/server_tokens off/" /etc/nginx/nginx.conf
# Check status
sudo service nginx
# Start nginx if it is not already running
sudo service nginx start
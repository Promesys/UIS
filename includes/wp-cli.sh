#!/bin/bash

# Install WP-CLI
echo "Installing WP-CLI..."
echo ''
apt-get update
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
sudo wp cli update

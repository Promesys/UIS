#!/bin/bash

# Run an update and upgrade for packages
echo "Checking for available software updates..."
echo ''
sudo apt-get update -y
echo "Applying critical updates..."
echo ''
sudo apt-get upgrade -y
# Install essential dependencies
echo "Installing essential dependencies..."
echo ''
sudo apt-get install -y build-essential
#!/bin/bash

# Configure WordPress
echo "Configuring WordPress..."
echo ''
read -p "Please provide the domain name: " domainName
echo ""
echo "Provided domainname:" $domainName
directoryName="/var/www/$domainName"
cd $directoryName
# tagline
wp option update blogdescription ''
# Install the Dutch core language pack.
wp language core install nl_NL
# Activate the Dutch core language pack.
wp site switch-language nl_NL
# Set the timezone string.
wp option update timezone_string "Europe/Amsterdam"
# Delete installed posts.
wp post delete $(wp post list --post_type='post' --format=ids) --force
# Delete an existing comment.
wp comment delete 1 --force
# Remove Base Plugins
wp plugin delete hello
wp plugin delete akismet
# Installs theme
wp theme install "Sydney"
# Creates blank child theme and enables it
wp scaffold child-theme Sydney-child --parent_theme=sydney --theme_name="Sydney Child" --author='Chris' --activate
# Plugins to be activated
wp plugin install elementor --activate
wp plugin install duplicate-post --activate
wp plugin install sydney-toolbox --activate
wp plugin install wp-serverinfo --activate
wp plugin install smart-slider-3 --activate
wp plugin install wp-mail-smtp --activate
wp plugin install redis-object-cache --activate
# Remove themes
wp theme delete twentynineteen
wp theme delete twentyseventeen
wp theme delete twentysixteen
# Update permalink structure
wp option update permalink_structure '/%postname%'
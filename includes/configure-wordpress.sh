#!/bin/bash

# Configure WordPress
echo "Configuring WordPress..."
echo ''
read -p "Please provide the domain name: " domainName
DBName=${domainName//./_}
echo ""
echo "Provided domainname:" $domainName
directoryName="/var/www/$domainName"
cd $domainName
wp cli Update
# tagline
sudo -u www-data wp option update blogdescription ''
# Install the Dutch core language pack.
sudo -u www-data wp language core install nl_NL
# Activate the Dutch core language pack.
sudo -u www-data wp language core activate nl_NL
# Set the timezone string.
sudo -u www-data wp option update timezone_string "Europe/Amsterdam"
# Delete installed posts.
sudo -u www-data wp post delete $(wp post list --post_type='post' --format=ids) --force
# Delete an existing comment.
sudo -u www-data wp comment delete 1 --force
# Remove Base Plugins
sudo -u www-data wp plugin delete hello
sudo -u www-data wp plugin delete akismet
# Installs theme
sudo -u www-data wp theme install "Sydney"
# Creates blank child theme and enables it
sudo -u www-data wp scaffold child-theme Sydney-child --parent_theme=Sydney --theme_name="Sydney Child" --author='Chris' --author_uri='' --theme_uri='' --activate
# Plugins to be activated
declare -a arr=("elementor" "duplicate post" "sydney toolbox" "wp-serverinfo" "smart slider 3" "wp mail smtp" "redis object cache")
for i in "${arr[@]}"
do
    sudo -u www-data wp plugin install $i --activate
done
# Remove themes
sudo -u www-data wp theme delete twentynineteen
sudo -u www-data wp theme delete twentyseventeen
sudo -u www-data wp theme delete twentysixteen
# Update permalink structure
sudo -u www-data wp rewrite structure '/%postname%'
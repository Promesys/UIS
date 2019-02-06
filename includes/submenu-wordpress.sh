#!/bin/bash

showMenu(){
    echo "---------------------------"
    echo " Please make your choice : "
    echo "---------------------------"
    echo "[1] Install WordPress"
    echo "[2] Install WP-CLI"
    echo "[3] Configure WordPress"
    echo "[4] Install Redis"
    echo "[0] Terug"
    echo "---------------------------"
    read -p "Please make a selection: " mc
    return $mc
}

while [[ "$m" != "0" ]]
do
    if [[ "$m" == "1" ]]; then
        echo "--------------"
        echo "Install WordPress."
        echo "--------------"
        ./includes/wordpress.sh
    elif [[ "$m" == "2" ]]; then
        echo "--------------"
        echo "Install WP-CLI."
        echo "--------------"
        ./includes/wp-cli.sh
    elif [[ "$m" == "3" ]]; then
        echo "--------------"
        echo "Configure WordPress."
        echo "--------------"
        sudo -u www-data ./includes/configure-wordpress.sh
    elif [[ "$m" == "4" ]]; then
        echo "--------------"
        echo "Install Redit."
        echo "--------------"
        ./includes/redis.sh
    fi
    showMenu
    m=$?
done
exit 0;
../uid-start.sh
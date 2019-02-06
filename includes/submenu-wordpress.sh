#!/bin/bash

showMenu(){
    echo "---------------------------"
    echo " Please make your choice : "
    echo "---------------------------"
    echo "[1] Install WordPress"
    echo "[2] Install WP-CLI"
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
        ./wordpress.sh
    elif [[ "$m" == "2" ]]; then
        echo "--------------"
        echo "Install WP-CLI."
        echo "--------------"
        ./wp-cli.sh
    fi
    showMenu
    m=$?
done
exit 0;
../uid-start.sh
#!/bin/bash

showMenu(){
    echo "----------------"
    echo "    menu"
    echo "----------------"
    echo "[1] hello"
    echo "[2] bye"
    echo "[3] exit"
    echo "----------------"
    read -p "Please Select A Number: " mc
    return $mc
}

while [[ "$m" != "3" ]]
do
    if [[ "$m" == "1" ]]; then
        echo "hello"
    elif [[ "$m" == "2" ]]; then
        echo "bye"
    fi
    showMenu
    m=$?
done

exit 0;
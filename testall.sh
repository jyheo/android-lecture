#!/bin/bash

find_apks() {
    find -name *.apk
}

for item in $(find_apks); do
    echo $item
    ./apk_install.sh i $item
    read -p "Enter score: " score
    ./apk_install.sh u $item
    if [[ $score == "q" ]]; then
        exit 0
    fi
    echo "$item $score" >> score.txt
done

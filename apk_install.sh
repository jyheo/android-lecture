#!/bin/bash

ANDROID_SDK="/mnt/c/Users/jyheo/AppData/Local/Android/Sdk"
ADB="$ANDROID_SDK/platform-tools/adb.exe"
AAPT="$ANDROID_SDK/build-tools/28.0.3/aapt.exe"

if (($# != 2)); then
    echo "Usage: $0 [i|u] apk"
    exit 1;
fi

opt=$1
apk=$2

if [[ $opt != "i" ]] && [[ $opt != "u" ]]; then
    echo "Usage: $0 [i|u] apk"
    exit 1;
fi

get_pkg_name() {
    $AAPT dump badging $apk | awk -v FS="'" '/package: name=/{print $2}'
}

#$ADB devices
pkg_name="$(get_pkg_name)"

if [[ $opt == "i" ]]; then
    echo "adb install -r $apk"
    $ADB install -r $apk
    echo "adb shell am start -n $pkg_name/$pkg_name.MainActivity"
    $ADB shell am start -n $pkg_name/$pkg_name.MainActivity
elif [[ $opt == "u" ]]; then
    echo "adb uninstall $pkg_name"
    $ADB uninstall $pkg_name
fi


#!/bin/bash
set -eu # in case an error occurs

if [ ! -f /etc/debian_version ]; then
    echo -e "\e[0;31mYou're not even running Debian!\e[0m"
    exit
else
    echo "\e[0;32mYou're running a Debian based distro. Contiuning...\e[0m"
fi

if [[ "$EUID" -ne 0 ]]; then
   echo -e "\e[0;31mFuck it! You're not running the script as root\e[0m" 
   exit 1
fi

echo test

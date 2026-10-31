#!/bin/bash
set -eu # in case an error occurs

RED="\e[0;31m"
GREEN="\e[0;32m"
RESET="\e[0m"
if [ ! -f /etc/debian_version ]; then
    echo -e "$RED[ERROR]$RESET You're not even running Debian!"
    exit
else
    echo -e "$GREEN[SUCCESS]$RESET You're running a Debian based distro. Contiuning..."
fi

if [[ "$EUID" -ne 0 ]]; then
   echo -e "$RED[ALERT]$RESET Fuck it! You're not running the script as root" 
   exit 1
fi

apt install nano ufw

# ------------ DOCKER ------------
sudo apt update
sudo apt install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# ------------ DOCKER END ------------






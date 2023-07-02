#!/bin/bash

# Installing the dependencies
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential git python3-pip gfortran cmake ninja-build git-lfs
pip install scons --user
pip install meson --user

# Removing snapd
sudo snap remove $(snap list | awk '!/^Name/ {print $1}')
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service
sudo apt remove --purge -y snapd

# Removing mounting /boot/efi
sudo sed -i '/\/boot\/efi/d' /etc/fstab
sudo systemctl stop boot-efi.mount
sudo systemctl disable boot-efi.mount

# Removing cloud-init
sudo touch /etc/cloud/cloud-init.disabled
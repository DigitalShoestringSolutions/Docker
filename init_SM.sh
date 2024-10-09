#!/bin/bash

# Install Docker on a Raspberry Pi


# Check for available updates
sudo apt-get update

# Make sure the certificate handler and curl utilities are installed
sudo apt-get install ca-certificates curl -y

# Modern install method: add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the latest version of some Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


# Lets the user account run Docker without elevated privileges
sudo usermod -a -G docker $USER

# Starts Docker running in the background
sudo systemctl start docker

# Sets Docker to run in the background whenever the board starts up
sudo systemctl enable docker

# Note: the user now needs to log out and in again (or reboot) 
# for the permission changes above to take effect

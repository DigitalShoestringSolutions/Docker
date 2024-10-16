#!/bin/bash

# Install Docker on a Raspberry Pi


# Check for available updates
sudo apt-get -qq update

# Make sure the certificate handler and curl utilities are installed
sudo apt-get -qq install ca-certificates curl -y

# Modern install method: add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -qq update

# Install the latest version of some Docker packages
echo "        Installing docker packages..."
sudo apt-get -qq install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


# Lets the user account run Docker without elevated privileges
echo "        Adding current user to docker user group..."
sudo usermod -a -G docker $USER

# Starts Docker running in the background
echo "        Starting docker now and on every boot..."
sudo systemctl start docker

# Sets Docker to run in the background whenever the board starts up
sudo systemctl enable docker

# Test the install by printing the version numbers
echo -n "        Installed "
docker -v
echo -n "        Installed "
docker compose version

# Note: the user now needs to log out and in again (or reboot)
# for the permission changes above to take effect
echo "        User permissions will be applied after the next reboot"

#!/bin/bash

# Install Docker on a Raspberry Pi


# Check for available updates
sudo apt update

# Make sure the curl utility is installed
sudo apt install curl -y

# Use curl to install docker
curl -sSL https://get.docker.com | sh
# If already installed displays a warning message, 
# but no issues have been observed

# Lets the user account run Docker without elevated privileges
sudo usermod -a -G docker $USER

# Starts Docker running in the background
sudo systemctl start docker

# Sets Docker to run in the background whenever the board starts up
sudo systemctl enable docker

# docker compose should be included, but in case it is not:
sudo apt install docker-compose-plugin

# Note: the user now needs to log out and in again (or reboot) 
# for the permission changes above to take effect

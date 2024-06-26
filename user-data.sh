#!/bin/bash

# Update the package list and upgrade the installed packages
sudo apt-get update -y
sudo yum update 

# Install OpenJDK headless without recommended packages
sudo apt install -y --no-install-recommends openjdk-17-jdk-headless
sudo yum install java-17-openjdk -y

# Install Docker
sudo apt-get install -y docker.io
sudo yum install docker -y

# Start the Docker service
sudo systemctl start docker
sudo systemctl enable docker
usermod -aG docker ubuntu 

echo "edit file /root/.ssh/authorized_keys"
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8eBTiUEmw43QgJXF/+Bqqy7hLB3Zm7fWxSzIrhgFDw jenkins@ip-172-31-55-133" >> /root/.ssh/authorized_keys

# Edit sshd_config file
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Restart SSH service (adjust the command based on your system)
sudo systemctl restart ssh

# Docker scout install
curl -sSfL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh | sh -s -- -b /usr/local/bin


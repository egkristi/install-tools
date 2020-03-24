#!/bin/bash

sudo apt remove -qq -y docker docker-engine docker.io containerd runc
sudo apt install -qq -y apt-transport-https ca-certificates gnupg-agent software-properties-common
wget -qO- https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update -qq
sudo apt install -qq -y docker-ce docker-ce-cli containerd.io
sudo systemctl disable docker
sudo systemctl start docker
sudo setfacl -m user:$USER:rw /var/run/docker.sock
docker version
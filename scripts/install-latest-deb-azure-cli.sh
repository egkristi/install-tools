#!/bin/bash

sudo apt install -qq -y ca-certificates apt-transport-https lsb-release gnupg
wget -qO- "https://packages.microsoft.com/keys/microsoft.asc" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update -qq
sudo apt-get install -qq -y azure-cli
az version
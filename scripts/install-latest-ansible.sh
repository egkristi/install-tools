#!/bin/bash

sudo apt install -qq -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -qq -y ansible
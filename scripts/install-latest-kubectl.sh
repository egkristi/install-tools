#!/bin/bash

sudo wget -qO "/usr/local/bin/kubectl" "https://storage.googleapis.com/kubernetes-release/release/$(wget -qO- https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x /usr/local/bin/kubectl
kubectl completion bash >> ~/.bash_completion
kubectl version
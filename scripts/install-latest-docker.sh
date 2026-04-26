#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing Docker CE..."

case "$PM" in
  apt)
    # Remove old versions
    sudo apt remove -qq -y docker docker-engine docker.io containerd runc 2>/dev/null || true
    install_deps ca-certificates curl gnupg

    # Add Docker's official GPG key using modern keyrings
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL "https://download.docker.com/linux/${DISTRO}/gpg" | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg 2>/dev/null || true
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${DISTRO} $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -qq
    sudo apt-get install -qq -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
    ;;
  dnf)
    sudo dnf remove -q -y docker docker-client docker-common docker-engine 2>/dev/null || true
    sudo dnf install -q -y dnf-plugins-core
    sudo dnf config-manager --add-repo "https://download.docker.com/linux/${DISTRO}/docker-ce.repo" 2>/dev/null || \
      sudo dnf config-manager --add-repo "https://download.docker.com/linux/centos/docker-ce.repo"
    sudo dnf install -q -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
    ;;
  *)
    error "Unsupported package manager: $PM"
    exit 1
    ;;
esac

# Add current user to docker group
sudo usermod -aG docker "$USER" 2>/dev/null || true

sudo systemctl enable docker
sudo systemctl start docker
docker version
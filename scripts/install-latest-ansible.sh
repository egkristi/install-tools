#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing Ansible..."

case "$PM" in
  apt)
    install_deps software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    install_deps ansible
    ;;
  dnf)
    sudo dnf install -q -y ansible
    ;;
  *)
    error "Unsupported package manager: $PM"
    exit 1
    ;;
esac

ansible --version
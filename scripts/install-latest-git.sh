#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing latest Git..."

case "$PM" in
  apt)
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update -qq
    install_deps git
    ;;
  dnf)
    sudo dnf install -q -y git
    ;;
  *)
    error "Unsupported package manager: $PM"
    exit 1
    ;;
esac

git version
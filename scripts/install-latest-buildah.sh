#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing Buildah..."

case "$PM" in
  apt)
    install_deps buildah
    ;;
  dnf)
    sudo dnf install -q -y buildah
    ;;
  *)
    error "Unsupported package manager: $PM"
    exit 1
    ;;
esac

buildah version
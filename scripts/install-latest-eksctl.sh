#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing eksctl..."

PLATFORM="$(uname -s)_${ARCH}"
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz" | sudo tar xz -C /usr/local/bin

eksctl version
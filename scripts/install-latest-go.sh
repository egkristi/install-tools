#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing latest Go..."

install_deps jq curl

# Use go.dev API to get the latest stable version
GO_VERSION="$(curl -sL 'https://go.dev/dl/?mode=json' | jq -r '.[0].version')"

info "Downloading ${GO_VERSION} for linux/${ARCH}..."
curl -sL "https://go.dev/dl/${GO_VERSION}.linux-${ARCH}.tar.gz" | sudo tar xz -C /usr/local

# Set up PATH persistently
echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/go-lang.sh > /dev/null

/usr/local/go/bin/go version
#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing kubectl..."

install_deps curl

KUBECTL_VERSION="$(curl -sL https://dl.k8s.io/release/stable.txt)"
info "Downloading kubectl ${KUBECTL_VERSION} for linux/${ARCH}..."

curl -sL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl" -o "${WORK_DIR}/kubectl"
sudo install -o root -g root -m 0755 "${WORK_DIR}/kubectl" /usr/local/bin/kubectl

# Set up bash completion (idempotent)
COMPLETION_LINE='source <(kubectl completion bash)'
if ! grep -qF "$COMPLETION_LINE" ~/.bashrc 2>/dev/null; then
  echo "$COMPLETION_LINE" >> ~/.bashrc
fi

kubectl version --client
#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing AWS CLI v2..."

# Map arch for AWS CLI download
case "$ARCH" in
  amd64) AWS_ARCH="x86_64" ;;
  arm64) AWS_ARCH="aarch64" ;;
  *)     error "Unsupported architecture for AWS CLI: $ARCH" ; exit 1 ;;
esac

wget -q -O "${WORK_DIR}/awscli.zip" "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip"
unzip -qq -o "${WORK_DIR}/awscli.zip" -d "${WORK_DIR}"

if [ -d /usr/local/aws-cli ]; then
  sudo "${WORK_DIR}/aws/install" --update
else
  sudo "${WORK_DIR}/aws/install"
fi

aws --version
#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing Terraform..."

install_deps jq curl unzip

# Get latest stable version from HashiCorp releases API
TF_VERSION="$(curl -sL https://releases.hashicorp.com/terraform/index.json \
  | jq -r '[.versions[].version | select(test("alpha|beta|rc|oci") | not)] | sort_by(split(".") | map(tonumber)) | last')"

info "Downloading Terraform ${TF_VERSION} for linux/${ARCH}..."
curl -sL "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_${ARCH}.zip" -o "${WORK_DIR}/terraform.zip"
unzip -qq "${WORK_DIR}/terraform.zip" -d "${WORK_DIR}"
sudo install -o root -g root -m 0755 "${WORK_DIR}/terraform" /usr/local/bin/terraform

terraform version

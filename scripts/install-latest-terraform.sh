#!/bin/bash
. "$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"/common.sh
sudo apt install -qq -y jq
wget -nc -qO "/tmp/terraform.zip" "$(wget -qO- https://releases.hashicorp.com/terraform/index.json \
  | jq -r '.versions[].builds[] | select((.version | contains ("rc"|"beta"|"alpha"|"oci") | not) and (.os == "linux") and (.arch == "${ARCH")).url' \
  | sort -u -V | tail -1)"
unzip -qq /tmp/terraform.zip
sudo mv terraform /usr/local/bin/
terraform version
#!/bin/bash
. "$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"/common.sh

wget -qO- "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_${ARCH}.tar.gz" | sudo tar xz -C /usr/local/bin
eksctl version
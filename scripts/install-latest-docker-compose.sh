#!/bin/bash
. "$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"/common.sh
sudo apt install -qq -y jq
sudo wget -nc -qO "/usr/local/bin/docker-compose" "$(wget -qO- https://api.github.com/repos/docker/compose/releases/latest | jq -r ".assets[] | select(.name == \"docker-compose-Linux-${ARCH_X86}\").browser_download_url")"
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
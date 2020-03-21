#!/bin/bash
. "$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"/common.sh

wget -qO- "$(wget -qO- https://golang.org/dl/ \
  | grep -o "https://dl.google.com/go/go[0-9]\{1,\}\.[0-9]\{0,\}\.[0-9]\{0,\}\.\{0,\}linux-${ARCH}.tar.gz" \
  | sort -V | tail -1)" | sudo tar xz -C /usr/local
echo "export PATH=$PATH:/usr/local/go/bin" | sudo tee /etc/profile.d/go-lang.sh
/usr/local/go/bin/go version
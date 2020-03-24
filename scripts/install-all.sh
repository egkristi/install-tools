#!/bin/bash

DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
. ${DIR}/common.sh

for INSTALLER in $(ls ${DIR}/install-latest-*); do
  . ${INSTALLER}
done
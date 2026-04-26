#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Select tools to install (arch: $ARCH, distro: $DISTRO, pm: $PM)"

FAILED=()
for INSTALLER in "${DIR}"/install-latest-*.sh; do
  TOOL="$(basename "$INSTALLER" .sh | sed 's/install-latest-//')"
  if yesno "Install ${TOOL}?" N; then
    info "--- Installing: $TOOL ---"
    if bash "$INSTALLER"; then
      info "$TOOL installed successfully"
    else
      warn "$TOOL installation failed"
      FAILED+=("$TOOL")
    fi
  fi
done

echo ""
if [ ${#FAILED[@]} -eq 0 ]; then
  info "Done!"
else
  warn "Failed to install: ${FAILED[*]}"
fi
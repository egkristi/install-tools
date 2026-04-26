#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing ALL tools (arch: $ARCH, distro: $DISTRO, pm: $PM)"

FAILED=()
for INSTALLER in "${DIR}"/install-latest-*.sh; do
  TOOL="$(basename "$INSTALLER" .sh | sed 's/install-latest-//')"
  info "--- Installing: $TOOL ---"
  if bash "$INSTALLER"; then
    info "$TOOL installed successfully"
  else
    warn "$TOOL installation failed"
    FAILED+=("$TOOL")
  fi
done

echo ""
if [ ${#FAILED[@]} -eq 0 ]; then
  info "All tools installed successfully!"
else
  warn "Failed to install: ${FAILED[*]}"
fi
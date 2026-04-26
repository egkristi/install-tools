#!/bin/bash
set -euo pipefail

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; }

# --- Architecture detection ---
MACHINE="$(uname -m)"
case "$MACHINE" in
  x86_64)  ARCH="amd64" ; ARCH_X86="x86_64" ;;
  aarch64) ARCH="arm64"  ; ARCH_X86="aarch64" ;;
  armv7l)  ARCH="arm"    ; ARCH_X86="armv7l" ;;
  *)       error "Architecture $MACHINE is not supported" ; exit 1 ;;
esac

# --- OS / package manager detection ---
if [ -f /etc/os-release ]; then
  DISTRO="$(grep -i '^ID=' /etc/os-release | cut -d= -f2 | tr -d '\"')"
  DISTRO_LIKE="$(grep -i '^ID_LIKE=' /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '\"' || true)"
else
  DISTRO="unknown"
  DISTRO_LIKE=""
fi

case "$DISTRO" in
  ubuntu|debian|linuxmint|pop) PM="apt" ;;
  rhel|centos|rocky|alma)      PM="dnf" ;;
  fedora)                      PM="dnf" ;;
  amzn)                        PM="yum" ;;
  *)
    case "$DISTRO_LIKE" in
      *debian*|*ubuntu*) PM="apt" ;;
      *rhel*|*fedora*)   PM="dnf" ;;
      *)                 PM="unknown" ;;
    esac
    ;;
esac

# --- Ensure common dependencies ---
install_deps() {
  local pkgs=("$@")
  case "$PM" in
    apt) sudo apt install -qq -y "${pkgs[@]}" ;;
    dnf) sudo dnf install -q -y "${pkgs[@]}" ;;
    yum) sudo yum install -q -y "${pkgs[@]}" ;;
    *)   warn "Cannot install dependencies: unknown package manager" ;;
  esac
}

# --- Temp directory with auto-cleanup ---
WORK_DIR="$(mktemp -d)"
cleanup() { rm -rf "$WORK_DIR"; }
trap cleanup EXIT

# --- Yes/no prompt ---
yesno() {
  while true; do
    case ${2:-^^} in
      Y|J) prompt="Y/n"; default=Y ;;
      N)   prompt="y/N"; default=N ;;
      *)   prompt="y/n"; default= ;;
    esac
    read -p "$1 [$prompt] " REPLY </dev/tty
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi
    case "$REPLY" in
      Y*|y*|J*|j*) return 0 ;;
      N*|n*)       return 1 ;;
    esac
  done
}

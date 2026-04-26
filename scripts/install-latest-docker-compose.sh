#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${DIR}/common.sh"

info "Installing Docker Compose v2 (plugin)..."

# Docker Compose v2 is now a Docker CLI plugin
install_deps jq curl

# Get latest release tag
COMPOSE_VERSION="$(curl -sL https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')"

DOCKER_CLI_PLUGINS="${HOME}/.docker/cli-plugins"
mkdir -p "$DOCKER_CLI_PLUGINS"

curl -sL "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-linux-${ARCH_X86}" -o "${DOCKER_CLI_PLUGINS}/docker-compose"
chmod +x "${DOCKER_CLI_PLUGINS}/docker-compose"

docker compose version
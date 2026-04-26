# install-tools

Install the latest version of common DevOps tools on Linux (Ubuntu/Debian and RHEL/Fedora/CentOS).

## Supported Tools

| Tool | Script |
|------|--------|
| Ansible | `install-latest-ansible.sh` |
| AWS CLI v2 | `install-latest-aws2-cli.sh` |
| Azure CLI | `install-latest-azure-cli.sh` |
| Buildah | `install-latest-buildah.sh` |
| Docker CE | `install-latest-docker.sh` |
| Docker Compose v2 | `install-latest-docker-compose.sh` |
| eksctl | `install-latest-eksctl.sh` |
| Git | `install-latest-git.sh` |
| Go | `install-latest-go.sh` |
| Helm 3 | `install-latest-helm.sh` |
| kubectl | `install-latest-kubectl.sh` |
| Terraform | `install-latest-terraform.sh` |

## Supported Platforms

- **Architectures**: x86_64 (amd64), aarch64 (arm64)
- **Distros**: Ubuntu, Debian, RHEL, CentOS, Rocky, Alma, Fedora, Amazon Linux

## Usage

```bash
# Install all tools
bash scripts/install-all.sh

# Interactive – choose which tools to install
bash scripts/install-selected.sh

# Install a single tool
bash scripts/install-latest-terraform.sh
```

## Features

- Automatic architecture detection (amd64/arm64)
- Automatic distro and package manager detection (apt/dnf/yum)
- Modern GPG key management (uses `/etc/apt/keyrings/`)
- Colored output with progress info
- Temp file auto-cleanup
- Error handling with `set -euo pipefail`
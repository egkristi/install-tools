#!/bin/bash

case $(getconf LONG_BIT) in
  64) ARCH="amd64" ; ARCH_AMD="amd64" ; ARCH_X86="x86_64" ;;
  32) ARCH="386" ; ARCH_AMD="386" ; ARCH_X86="x86_32" ;;
  *) echo "$(getconf LONG_BIT) is not supported" ; exit 1 ;;
esac

case $(cat /etc/os-release | grep -i id_like= | cut -d= -f2) in
  debian) PM="apt" ;;
  rhel) PM="yum" ;;
  rhel) PM="undefined" ;;
esac

DISTRO="$(cat /etc/os-release | grep -i id= | cut -d= -f2)"
case $DISTRO in
  ubuntu) PM="apt" ;;
  rhel) PM="apt" ;;
  *) PM="undefined" ;;
esac

# case $PM in
#   apt) sudo apt install -qq -y jq ;;
#   yum) sudo yum install -y jq ;;
#   *) echo "unable to install dependencies" ;;
# esac

yesno() {
while true; do
    case ${2:-^^} in
    Y|J)
        prompt="Y/n"
        default=Y
    ;;
    N)
        prompt="y/N"
        default=N
    ;;
    *)
        prompt="y/n"
        default=
    ;;
    esac
    # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
    read -p "$1 [$prompt] " REPLY </dev/tty
    # Default?
    if [ -z "$REPLY" ]; then
        REPLY=$default
    fi
    # Check if the reply is valid
    case "$REPLY" in
        Y*|y*|J*|j*) return 0 ;;
        N*|n*) return 1 ;;
    esac
done
}

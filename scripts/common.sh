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

# case $PM in
#   apt) sudo apt install -qq -y jq ;;
#   yum) sudo yum install -y jq ;;
#   *) echo "unable to install dependencies" ;;
# esac

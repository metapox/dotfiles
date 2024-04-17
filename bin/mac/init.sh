#!/usr/bin/env bash
set -ue

if  type brew > /dev/null 2>&1; then
  echo "skip: Install brew"
else
  echo "Install brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if type ansible > /dev/null 2>&1; then
  echo "skip: Install ansible"
else
  echo "Install ansible"
  brew install ansible
fi

path=$(cd $(dirname $0)/../../; pwd)
echo "path: $path"
ansible-playbook $path/ansible/setup_mac.yaml

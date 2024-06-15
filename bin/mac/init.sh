#!/usr/bin/env bash
set -ue

PWD=$(cd $(dirname $0); pwd)
echo $PWD

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

ansible_path=$(cd $(dirname $0)/../../ansible; pwd)

inventory_file_path=$(ls $ansible_path/inventories | fzf --prompt="Select inventory file path: ")

echo "$ansible_path/inventories/$inventory_file_path" 
if [ ! -d "$ansible_path/inventories/$inventory_file_path" ]; then
  echo "Please execute the following command."
  echo "$PWD"/build_config.sh
  exit 1
fi

ansible-playbook -c local -i $ansible_path/inventories/$inventory_file_path/hosts.yaml $ansible_path/setup_mac.yaml 

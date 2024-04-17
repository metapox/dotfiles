#!/usr/bin/env bash
set -ue

PWD=$(cd $(dirname $0); pwd)
ROOT=$(cd $PWD/../../; pwd)
echo "path: $PWD"

read -p "Please enter the name of the directory you want to create: " dir_name

if [ ! -n "$dir_name" ]; then
  echo "The directory name is empty."
  exit 1
fi

if [ -d "$ROOT/ansible/inventories/$dir_name" ]; then
  echo "The directory already exists."
else
  mkdir -p "$ROOT/ansible/inventories/$dir_name"
  echo "Created a directory named $dir_name."
fi

if [ -f "$ROOT/ansible/inventories/$dir_name/hosts.yaml" ]; then
  echo "The hosts file already exists."
else
  touch "$ROOT/ansible/inventories/$dir_name/hosts.yaml"
  cat <<EOF > "$ROOT/ansible/inventories/$dir_name/hosts.yaml"
all:
    hosts:
        localhost
EOF
  echo "Created a hosts file."
fi

if [ -f "$ROOT/ansible/inventories/$dir_name/host_vars/localhost.yaml" ]; then
  echo "The group_vars file already exists."
else
  mkdir -p "$ROOT/ansible/inventories/$dir_name/host_vars"
  touch "$ROOT/ansible/inventories/$dir_name/host_vars/localhost.yaml"

  cat <<EOF > "$ROOT/ansible/inventories/$dir_name/host_vars/localhost.yaml"
---
git:
  name: # git configに登録されるname
  email: # git configに登録されるemail address
EOF

  echo "Created a group_vars file."
fi
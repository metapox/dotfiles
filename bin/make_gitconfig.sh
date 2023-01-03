#!/usr/bin/env bash
set -ue

SCRIPT_DIR=$(cd $(dirname $0); pwd)

read -p "Enter the global git user name: " NAME
read -p "Enter the global git user email-address: " EMAIL
export NAME=${NAME}
export EMAIL=${EMAIL}

cat "${SCRIPT_DIR}/../git/templates/gitconfig.template" | envsubst > "${SCRIPT_DIR}/../git/.gitconfig"

#!/usr/bin/env bash
set -ue

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# brew

# zsh
brew install --cask zsh
cp "${SCRIPT_DIR}/../zsh/.zshrc" ~/.zshrc


# warp
brew install --cask warp


# vim

# vscode

# golang
# docker

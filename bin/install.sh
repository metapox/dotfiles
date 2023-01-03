#!/usr/bin/env bash
set -ue

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# TODO
#

# brew

# install tools
echo "=== 必要なツールをインストールします。==="
echo ""

brew install gettext
brew link --force gettext

echo "=== 必要なツールのインストールが完了しました。==="
echo ""

# zsh
echo "=== zsh の設定を開始します。==="
echo ""

brew install --cask zsh
touch ~/.zshrc
cp ~/.zshrc ~/.zshrc.bk
cp "${SCRIPT_DIR}/../zsh/.zshrc" ~/.zshrc

echo "zsh の設定が完了しました。"
echo ""

# warp
echo "=== warp の設定を開始します。==="
echo ""
brew install --cask warp
echo "=== warp の設定が完了しました。==="
echo ""

# git/github
echo "=== git の設定を開始します。==="
echo ""

mkdir -p ~/.config/git
touch ~/.config/git/ignore
cp ~/.config/git/ignore ~/.config/git/ignore.bk
cp "${SCRIPT_DIR}/../git/global_gitignore" ~/.config/git/ignore

source "${SCRIPT_DIR}/make_gitconfig.sh"
touch ~/.gitconfig
cp ~/.gitconfig ~/.gitconfig.bk
cp "${SCRIPT_DIR}/../git/.gitconfig" ~/.gitconfig

echo "=== git の設定が完了しました。==="
echo ""

# vim

# vscode

# golang
# docker

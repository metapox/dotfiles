#!/usr/bin/env bash
set -ue

echo $SHELL

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# TODO
# echoが汚い (echo の部分も共通関数にできるようにしたい)
# それぞれ関数にしたい
# 途中で失敗しても続きからできるようにしたい
# git-secretとgit ファイルの別々になってる問題

# brew
# install tools
echo "=== 必要なツールをインストールします。==="
echo ""

brew install gettext
brew link --force gettext

brew install fzf
brew install repgrep

echo "=== 必要なツールのインストールが完了しました。==="
echo ""

# zsh
# echo "=== zsh の設定を開始します。==="
# echo ""

# brew install --cask zsh
# touch ~/.zshrc
# cp ~/.zshrc ~/.zshrc.bk
# cp "${SCRIPT_DIR}/../zsh/.zshrc" ~/.zshrc
# chsh -s /bin/zsh

# echo ""=== zsh の設定が完了しました。 ==="
# echo ""

# fish
echo "=== fish の設定を開始します。==="
echo ""

brew install fish
SHELL_FILE="/etc/shells"
FISH_PATH="/usr/local/bin/fish"

sudo -s << COMMAND
if ! grep -q "$FISH_PATH" "$SHELL_FILE"; then
  echo "$FISH_PATH" >> "$SHELL_FILE"
fi
COMMAND
chsh -s /usr/local/bin/fish

cp ~/.config/fish/config.fish ~/.config/config.fish
cp -r "${SCRIPT_DIR}/../config.fish" ~/.config/fish/config.fish

echo "=== fish の設定が完了しました。==="
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

# git-secret
echo "=== git-secret の設定を開始します。==="
echo ""

brew install git-secrets
git secrets --register-aws

echo "=== git-secre の設定が完了しました。==="
echo ""


# vim

# vscode

# golang
# docker

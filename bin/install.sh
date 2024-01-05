#!/usr/bin/env bash
set -ue

echo $SHELL

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# functions

function attach_config() {
  file_path=$1
  source_path=$2

  if [ -f $file_path ]; then
    cp -r $file_path $file_path.bk
    cp -r $source_path $file_path
    patch_to_file $file_path.bk $file_path
  else
    mkdir -p $(dirname $file_path)
    cp -r $source_path $file_path
  fi
}

function patch_to_file() {
  backup_file=$1
  target_file=$2
  echo $backup_file
  echo $target_file

  # ファイル間の差分を取得
  DIFF_OUTPUT=$(echo "$(diff -u $target_file $backup_file)")
  echo $DIFF_OUTPUT

  # 差分が存在する場合、ユーザーにパッチの適用を尋ねる
  if [ -n "$DIFF_OUTPUT" ]; then
    echo $DIFF_OUTPUT

    echo "差分が存在します。パッチを適用しますか？ [y/N]"
    read answer
    if [ "$answer" = "y" ]; then
      echo "$DIFF_OUTPUT" | patch $target_file
      echo "パッチを適用しました。"
    else
      echo "パッチの適用をスキップしました。"
    fi
  else
    echo "差分は存在しません。"
  fi
}

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
brew install ripgrep
brew install derailed/k9s/k9s

echo "=== 必要なツールのインストールが完了しました。==="
echo ""

# zsh
echo "=== zsh の設定を開始します。==="
echo ""

brew install zsh
attach_config ~/.zshrc "${SCRIPT_DIR}/../zsh/.zshrc"
chsh -s /bin/zsh

echo "=== zsh の設定が完了しました。 ==="
echo ""

# fish
# echo "=== fish の設定を開始します。==="
# echo ""

# brew install fish
# SHELL_FILE="/etc/shells"
# FISH_PATH="/usr/local/bin/fish"

# sudo -s << COMMAND
# if ! grep -q "$FISH_PATH" "$SHELL_FILE"; then
#   echo "$FISH_PATH" >> "$SHELL_FILE"
# fi
# chsh -s /usr/local/bin/fish
# COMMAND

# attach_config ~/.config/fish/config.fish "${SCRIPT_DIR}/../fish/config.fish"

# echo "=== fish の設定が完了しました。==="
# echo ""

# warp
# echo "=== warp の設定を開始します。==="
# echo ""
# brew install --cask warp
# echo "=== warp の設定が完了しました。==="
# echo ""

# git/github
echo "=== git の設定を開始します。==="
echo ""

attach_config ~/.config/git/ignore "${SCRIPT_DIR}/../git/global_gitignore"

source "${SCRIPT_DIR}/make_gitconfig.sh"
attach_config ~/.gitconfig "${SCRIPT_DIR}/../git/.gitconfig"

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

#!/usr/bin/env bash
set -ue

echo $SHELL

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# functions
function patch_to_file() {
  backup_file=$1
  target_file=$2

  # ファイル間の差分を取得
  DIFF_OUTPUT=$(diff $target_file $backup_file)

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
chsh -s /usr/local/bin/fish
COMMAND

cp ~/.config/fish/config.fish ~/.config/config.fish.bk
cp -r "${SCRIPT_DIR}/../fish/config.fish" ~/.config/fish/config.fish
patch_to_file ~/.config/config.fish.bk ~/.config/fish/config.fish

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
patch_to_file ~/.config/git/ignore.bk ~/.config/git/ignore

source "${SCRIPT_DIR}/make_gitconfig.sh"
touch ~/.gitconfig
cp ~/.gitconfig ~/.gitconfig.bk
cp "${SCRIPT_DIR}/../git/.gitconfig" ~/.gitconfig
patch_to_file ~/.gitconfig.bk ~/.gitconfig

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

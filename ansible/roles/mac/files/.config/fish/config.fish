if status is-interactive
<<<<<<< HEAD
    # eval (/opt/homebrew/bin/brew shellenv)
end
=======
    eval (/opt/homebrew/bin/brew shellenv)
end

# aliasの読み込み
alias dc='docker-compose'

# 関数ファイルの読み込み
find ~/.config/fish/functions/ -name '*.fish' | while read file
  source $file
end

# カスタム設定ファイルの読み込み
source ~/.config/fish/custom_config.fish
>>>>>>> 08c3d67 (fix: fish custom)

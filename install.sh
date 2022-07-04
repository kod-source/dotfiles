#!/bin/bash

for f in .??*; do
    [ "$f" = ".git" ] && continue
	ln -s ~/dotfiles/"$f" ~/"$f"
done

if [ ! -f /opt/homebrew/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Brewfileの実行
# brew bundle -v --file ~/dotfiles/Brewfile

# SHELLをfishに変更
# chsh -s /opt/homebrew/bin/fish

# zsh-autosuggestionsのインストール
# if [ ! -e ~/.zsh/zsh-autosuggestions ]; then
#     git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# fi

# エイリアスの追加
# alias ll='exa --time-style=long-iso -gl'

# Mac Setup
# ./mac/setup.sh
#!/bin/bash

for i in "$@"; do
    case "$i" in
        -s|--skip-apps)
            skip_apps=1
            shift ;;
        *) ;;
    esac
done

if [ ! -d ~/dotfiles ]; then
    cd ~
    git clone https://github.com/kod-source/dotfiles.git
    cd dotfiles
fi

for f in .??*; do
    [ "$f" = ".git" ] && continue
	ln -s ~/dotfiles/"$f" ~/"$f"
done

if [ ! -f /opt/homebrew/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Brewfileの実行
if [ ! "$skip_apps" ]; then
    brew bundle -v --file ~/dotfiles/Brewfile
fi


# zsh-autosuggestionsのインストール
if [ ! -e ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

# SHELLをfishに変更
chsh -s /opt/homebrew/bin/fish

# VSCode
./vscode/setup.sh

# iTerm2
./iterm2/setup.sh

# Rectangle
./rectangle/setup.sh

# Mac Setup
./mac/setup.sh

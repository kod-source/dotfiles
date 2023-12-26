#!/bin/zsh
# .zshrc

if command -v direnv > /dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

if command -v nodenv > /dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

if command -v plenv > /dev/null 2>&1; then
    eval "$(plenv init -)"
fi

if command -v rbenv > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

if command -v pyenv > /dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export PATH="/opt/homebrew/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# 環境変数
export LANG=ja_JP.UTF-8

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# 直前のコマンドの重複を削除
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧をカラー表示
autoload colors
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct
# ビープ音を鳴らさない
setopt no_beep

# ディレクトリスタック
DIRSTACKSIZE=100
setopt AUTO_PUSHD

# git-promptの読み込み
source ~/.zsh/git-prompt.sh

# git-completionの読み込み
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# プロンプトの表示設定(好きなようにカスタマイズ可)
setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
\$ '

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

. ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -f ~/.alias.zsh ] && source ~/.alias.zsh

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^g' peco-src

function peco-select-history() {
    BUFFER=$(fc -l -r -n 1 | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# AWSプロファイルを切り替えます
function paws {
  local profile=$(perl -nle 'print $1 if /^[[](?:profile\s+)?([^]]+)/' ~/.aws/config | peco)
  if [ -n "$profile" ]; then
    export AWS_PROFILE=$profile
    export TF_VAR_AWS_PROFILE=$profile
    echo "AWS_PROFILE is now $AWS_PROFILE"
    if echo $AWS_PROFILE | grep -q -- '-dev'; then
      export APP_ENV=development
    elif echo $AWS_PROFILE | grep -q -- '-stg'; then
      export APP_ENV=staging
    elif echo $AWS_PROFILE | grep -q -- '-prd'; then
      export APP_ENV=production
    fi
  fi
}

# 環境（development / staging / production / sandbox）を切り替える
function penv {
    local appenv=$( (echo development; echo staging; echo production) | peco)
    if [ -n "$appenv" ]; then
        APP_ENV=$appenv
        export APP_ENV
        echo "APP_ENV is now $APP_ENV"
    fi
}

# 現環境を表示する
function show {
  echo "APP_ENV: $APP_ENV"
  echo "AWS_PROFILE: $AWS_PROFILE"
}

# ターミナルの真ん中にカーソル移動
function jump_middle() {
    CURSOR=$((${#BUFFER} / 2))
    zle redisplay
}
zle -N jump_middle
# bindkey '^m' jump_middle

# git commitコマンドを定義
gcm() {
  zsh ~/dotfiles/scripts/alias/git_commit.sh
}

# git pushコマンドを定義
gpo() {
  zsh ~/dotfiles/scripts/alias/git_push.sh
}

# git force pushコマンドを定義
gpof() {
  zsh ~/dotfiles/scripts/alias/git_push.sh -f
}

# git stashコマンドを定義
gst() {
  zsh ~/dotfiles/scripts/alias/git_stash.sh
}

# git stashのファイル指定コマンドを定義
gstf() {
  zsh ~/dotfiles/scripts/alias/git_stash_file.sh
}

# git stash dropコマンドを定義
gstd() {
  zsh ~/dotfiles/scripts/alias/git_stash_drop.sh
}

# ide tmux
ide() {
  zsh ~/dotfiles/scripts/ide.sh
}
ide1() {
  zsh ~/dotfiles/scripts/ide.sh 1
}
ided() {
  zsh ~/dotfiles/scripts/ide.sh d
}

# alias global
alias -g B='git branch | awk "{print \$1}" | peco'
alias -g L='| less'
alias -g G='| grep'
alias -g sr='exec $SHELL -l'
alias -g PS='(ps -a | peco | sed -e "s/  */:/g" | sed -e "s/^://" | sed -e "s/:.*//" | tr "\n" " ")'

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export RBENV_ROOT=~/.rbenv
export PATH="${RBENV_ROOT}/bin:${PATH}"
eval "$(rbenv init -)"

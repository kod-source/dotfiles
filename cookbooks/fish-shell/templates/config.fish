set -g -x PATH $PATH /opt/homebrew/bin
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x PATH $HOME/.nodebrew/current/bin $PATH
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH  $PYENV_ROOT/bin $PATH
set PATH /usr/local/lib/ruby/gems/2.6.0/bin /usr/local/opt/ruby/bin $PATH
set -U gabbr_config ~/.config/fish/.gabbr.config
eval (direnv hook fish)
pyenv init - | source
status --is-interactive; and rbenv init - fish | source

if status is-interactive
# Commands to run in interactive sessions can go here
end

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)' # control + R
  bind \cx\ck peco_kill # control + X からの control + K
end

function peco_select_history_order
  if test (count $argv) = 0
    set peco_flags --layout=top-down
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function bind_global_alias
  commandline -rt '| less'
end

# fish key bindings
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cg ghq_peco_repo
  bind \cl bind_global_alias
  # gabbrを半角空白にキーバインド設定
  bind ' ' '__gabbr_expand; commandline -i " "'
  bind ';' '__gabbr_expand; commandline -i ";"'
end

if test -z $TMUX
  tmux new-session
end

starship init fish | source

# ghq + peco
function ghq_peco_repo
  set selected_repository (ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $selected_repository
    echo " $selected_repository "
    commandline -f repaint
  end
end

# AWSプロファイルを切り替えます
function paws
  set profile (perl -nle 'print $1 if /^[[](?:profile\s+)?([^]]+)/' ~/.aws/config | peco)
  if [ -n "$profile" ]
    set -gx AWS_PROFILE $profile
    set -gx TF_VAR_AWS_PROFILE $profile
    echo "AWS_PROFILE is now $AWS_PROFILE"
    if echo $AWS_PROFILE | grep -q -- '-dev';
      set -gx APP_ENV development
    else if echo $AWS_PROFILE | grep -q -- '-stg';
      set -gx APP_ENV staging
    else if echo $AWS_PROFILE | grep -q -- '-prd';
      set -gx APP_ENV production
    end
  end
end

# 環境 (development / staging / production / sandbox) を切り替える
function penv
  set appenv (echo -e 'development\nstaging\nproduction\nsandbox' | peco)
  if [ -n "$appenv" ]
    set -gx APP_ENV $appenv
    echo "APP_ENV is now $APP_ENV"
  end
end

# 現環境を表示する
function show
  echo -e "\033[1mAWS_PROFILE:\033[0m \033[32m$AWS_PROFILE\033[0m"
  echo -e "\033[1mAPP_ENV:\033[0m \033[31m$APP_ENV\033[0m"
end

# git commitのalias
function gcm
  sh ~/dotfiles/scripts/alias/git_commit.sh
end

# git pushのalias
function gpo
  sh ~/dotfiles/scripts/alias/git_push.sh
end

# git force pushのalias
function gpof
  sh ~/dotfiles/scripts/alias/git_push.sh -f
end

# git stashのalias
function gst
  sh ~/dotfiles/scripts/alias/git_stash.sh
end

# git stashのファイル単位で指定するalias
function gstf
  sh ~/dotfiles/scripts/alias/git_stash_file.sh
end

# git stash dropのalias
function gstd
  sh ~/dotfiles/scripts/alias/git_stash_drop.sh
end

# ide tmux
function ide
  sh ~/dotfiles/scripts/ide.sh
end
# ide tmux
function ide1
  sh ~/dotfiles/scripts/ide.sh 1
end
# ide dotfiles
function ided
  sh ~/dotfiles/scripts/ide.sh d
end

# gabbr reload（リロード処理を書かないと更新されない）
gabbr --reload

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/horikoudai/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/horikoudai/Downloads/google-cloud-sdk/path.fish.inc'; end

eval (nodenv init - | source)

# 展開エイリアスの設定
abbr -a sr 'exec $SHELL -l'

# by @GReagle@github
# https://github.com/fish-shell/fish-shell/issues/1963#issuecomment-93775067
function bind_global_alias
        switch (commandline -t)
  case "l"
    commandline -rt '| less '
  case "h"
    commandline -rt '| head '
  case "t"
    commandline -rt '| tail '
  case "g"
    commandline -rt '| grep '
  case "w"
    commandline -rt '| wc '
  case "cc"
    commandline -rt '| ccze -A '
  end
end

bind \cx bind_global_alias

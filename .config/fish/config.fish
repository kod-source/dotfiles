set -g -x PATH $PATH /opt/homebrew/bin
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

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

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

if test -z $TMUX
  tmux new-session
end

starship init fish | source

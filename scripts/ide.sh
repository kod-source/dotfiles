#!/usr/bin/env bash

set -euo pipefail

pane_ids=$(tmux list-panes | cut -d: -f1 | tac)

for pane_id in $pane_ids; do
    if [ "$pane_id" != "0" ]; then
        tmux kill-pane -t "$pane_id"
    fi
done

if [ "$#" -eq 0 ]; then
    tmux split-window -h
    tmux split-window -v
    tmux split-window -t 0 -v
    tmux resize-pane -t 0 -D 7
    tmux resize-pane -t 2 -D 15
    tmux resize-pane -R 10
    sleep 1
    tmux send-keys -t 0 "ghq_peco_repo; tmux select-pane -t 1; clear" C-m
    tmux send-keys -t 1 "ghq_peco_repo; tmux select-pane -t 2; clear" C-m
    tmux send-keys -t 2 "ghq_peco_repo; tmux select-pane -t 3; clear" C-m
    tmux send-keys -t 3 "ghq_peco_repo; tmux select-pane -t 0; clear; lazygit" C-m
else
    case $1 in
    1)
        tmux split-window -h
        tmux split-window -v -p 30
        tmux resize-pane -R 10
        sleep 1
        tmux send-keys -t 0 "ghq_peco_repo; clear" C-m
        tmux send-keys -t 1 "ghq_peco_repo; clear" C-m
        tmux send-keys -t 2 "ghq_peco_repo; clear; lazygit" C-m
        tmux select-pane -t 0
        ;;
    d)
        tmux split-window -h
        tmux split-window -v
        tmux resize-pane -R 10
        sleep 1
        tmux send-keys -t 0 "cd ~/dotfiles; clear" C-m
        tmux send-keys -t 1 "cd; clear" C-m
        tmux send-keys -t 2 "cd; clear" C-m
        tmux select-pane -t 0
        ;;
    *)
        echo "Invalid argument: $1"
        ;;
    esac
fi

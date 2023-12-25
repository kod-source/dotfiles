#!/bin/bash

stash_files=$(git stash list | peco | sed -e "s/:.*//")

if [[ -n "$stash_files" ]]; then
    read -p "$(tput setaf 1)(U^w^) < 本当にDropしてよろしいですか？ [y/N] $(tput sgr0)" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "$(tput setaf 5)(U^w^) < Dropをキャンセルしました"
        exit 1
    fi
    for i in $stash_files
    do
        git stash drop $i
    done
fi

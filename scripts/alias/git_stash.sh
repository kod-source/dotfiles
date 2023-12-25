#!/bin/bash

read -p "$(tput setaf 2)(U^w^) < stashメッセージを入力して下さい。: $(tput sgr0)" message

# -uのオプションをつけるか否か
read -p "$(tput setaf 2)(U^w^) < 新規作成したファイルもstashしますか？ [y/N]  " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    git stash save -u "$message"
else
    echo ""
    git stash save "$message"
fi

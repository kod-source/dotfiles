#!/bin/bash

# 変更のあるファイルパスを取得
files=$(git status --short | peco | awk '{print $2}')

# stashメッセージを入力
read -p "$(tput setaf 2)(U^w^) < stashメッセージを入力してください: $(tput sgr0)" message

# 選択したファイルをstash
git stash push -u -m "$message" -- $files

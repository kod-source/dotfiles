#!/bin/bash

# 現在のブランチ名を取得
branch=$(git branch --show-current)

# main/masterブランチの場合は確認メッセージを表示
if [[ "$branch" == "main" || "$branch" == "master" ]]; then
    read -p "$(tput setaf 1)(U^w^) < ${branch}ブランチに本当にpushしてよろしいですか？ [y/N] $(tput sgr0)" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "$(tput setaf 5)(U^w^) < Pushをキャンセルしました"
        exit 1
    fi
fi

# 引数に-fがある場合はforce pushを実行
if [[ "$1" == "-f" ]]; then
    read -p "$(tput setaf 1)(U^w^) < force pushしても宜しいですか？ [y/N] $(tput sgr0)" -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "$(tput setaf 5)(U^w^) < force pushをキャンセルしました"
            exit 1
        fi
    git push -f origin $branch
    exit 0
fi

# git pushを実行
git push origin $branch

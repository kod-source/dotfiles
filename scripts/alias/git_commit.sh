#!/bin/bash

read -p "$(tput setaf 2)(U^w^) < コミットメッセージを入力して下さい。: $(tput sgr0)" message
if [[ -z "$message" ]]; then # コミットメッセージが空の場合
    echo "$(tput setaf 1)(U^w^) < コミットメッセージが空です。$(tput sgr0)"
    exit 1
fi

# コミットメッセージを確認する
echo ""
echo ""
echo ""
echo ""
echo "$(tput setaf 4)(U^w^) < コミットメッセージは正しいですか [y/N]？: $(tput sgr0)$message"
read -p "$(tput setaf 4)Commit? [y/n] $(tput sgr0)" -n 1 -r
echo ""

# 現在のブランチ名を取得
branch=$(git branch --show-current)

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # main/masterブランチの場合は確認メッセージを表示
    if [[ "$branch" == "main" || "$branch" == "master" ]]; then
        read -p "$(tput setaf 1)(U^w^) < ${branch}ブランチに本当にcommitしてよろしいですか？ [y/N] $(tput sgr0)" -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "$(tput setaf 5)(U^w^) < Commitをキャンセルしました"
            exit 1
        fi
    fi
    echo "$(tput setaf 2)(U^w^) < Commitします。$(tput sgr0)"
    git commit -m "$message"

    # pushするか確認する
    read -p "$(tput setaf 2)(U^w^) < Pushも行いますか？ [y/n] $(tput sgr0)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # pushする
        echo ""
        ~/dotfiles/scripts/alias/git_push.sh
    else
        echo ""
        echo "$(tput setaf 5)(U^w^) < Commitのみ行いました。$(tput sgr0)"
    fi
else
    echo ""
    echo "$(tput setaf 5)(U^w^) < Commitをキャンセルしました。$(tput sgr0)"
fi

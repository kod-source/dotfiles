# 開発環境セットアップレシピ

開発環境をセットアップする [mitamae](https://github.com/itamae-kitchen/mitamae) レシピです。

## 使い方

2021年2月2日現在、**MacにはGitが標準でインストールされていません**。
Xcode Command Line Toolsなど任意の方法でGitをインストールしてください。

```
xcode-select --install
```

任意の場所にこのレポジトリをクローンします。
必ず `--recursive` オプションを指定してクローンしてください。
一部レシピが上手く実行できない場合があります([#8](https://github.com/fuller-inc/dotfiles/issues/8))。

```
git clone --recursive git@github.com:fuller-inc/dotfiles.git
```

クローンしたら、レポジトリ内で次のようにコマンドを実行します。

```
ROLE=base ./install.sh
```

## 各role毎にインストールされるソフトウェア

### 共通

- [Homebrew](https://brew.sh/index)
- [jq](https://stedolan.github.io/jq/)
- [peco](https://github.com/peco/peco)
- [ghq](https://github.com/x-motemen/ghq)
- tree
- [tmux](https://github.com/tmux/tmux)
- [iTerm2](https://iterm2.com)
- [Figma](https://www.figma.com)
- [Visual Studio Code](https://code.visualstudio.com)
- [Go](https://golang.org)
- [AWS CLI](https://aws.amazon.com/jp/cli/)
- [mkr](https://github.com/mackerelio/mkr)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [ecspresso](https://github.com/kayac/ecspresso)
- [gibo](https://github.com/simonwhitaker/gibo)
- [Git](https://git-scm.com)
- [Git Large File Storage](https://git-lfs.github.com)
- [rbenv](https://github.com/rbenv/rbenv)
- Rosetta 2

### Android

- [Android Studio](https://developer.android.com/studio?hl=ja)



## レシピの追加方法

### 新しいroleを追加したい場合

1. `role` ディレクトリ配下に、任意の名前のディレクトリを作成します。作成したディレクトリ名が `role` になります
1. 作成したディレクトリ配下に `default.rb` を作成します
1. `default.rb` に、そのroleでインストールするソフトウェア群を列挙します

### インストールするソフトウェアを追加する場合

`cookbooks` ディレクトリ配下に、ソフトウェアをインストールするためのレシピを追加します。
レシピは `<インストールするソフトウェア>/default.rb` の形式をとり、 `default.rb` にレシピを記述してください。

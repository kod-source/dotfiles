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

## レシピの追加方法

### 新しいroleを追加したい場合

1. `role` ディレクトリ配下に、任意の名前のディレクトリを作成します。作成したディレクトリ名が `role` になります
1. 作成したディレクトリ配下に `default.rb` を作成します
1. `default.rb` に、そのroleでインストールするソフトウェア群を列挙します

### インストールするソフトウェアを追加する場合

`cookbooks` ディレクトリ配下に、ソフトウェアをインストールするためのレシピを追加します。
レシピは `<インストールするソフトウェア>/default.rb` の形式をとり、 `default.rb` にレシピを記述してください。

#!/bin/bash

#
# Dock
#

# Dockからすべてのアプリを消す
defaults write com.apple.dock persistent-apps -array
# Dockのサイズ
defaults write com.apple.dock "tilesize" -int "16"
# Dockの最大サイズ
defaults write com.apple.dock "largesize" -int "200"
# 最近起動したアプリを非表示
defaults write com.apple.dock "show-recents" -bool "false"
# アプリをしまうときのアニメーション
defaults write com.apple.dock "mineffect" -string "scale"
# 使用状況に基づいてデスクトップの順番を入れ替え
defaults write com.apple.dock "mru-spaces" -bool "false"
# Dockを自動的に隠す
defaults write com.apple.dock autohide -bool true
# ディスプレイごとに個別の操作スペース
defaults write com.apple.spaces spans-displays -bool true
# 左下に、「Misson Control」を割り当て
defaults write com.apple.dock wvous-bl-corner -int 2
defaults write com.apple.dock wvous-bl-modifier -int 0
# 左上に、「スクリーンセーバーの開始」を割り当て
defaults write com.apple.dock wvous-tl-corner -int 5
defaults write com.apple.dock wvous-tl-modifier -int 0
# 右上に、「ディスプレイをスリープさせる」を割り当て
defaults write com.apple.dock wvous-tr-corner -int 10
defaults write com.apple.dock wvous-tr-modifier -int 0
# Dockの再起動
killall Dock

#
# Finder
#

# 拡張子まで表示
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# スクロールバーを常時表示する
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# スプリングロード遅延を除去する
defaults write NSGlobalDomain com.apple.springing.delay -float 0
# ディレクトリのスプリングロードを有効にする
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
# キーリピートの速度
defaults write NSGlobalDomain KeyRepeat -int 2
# キーリピート開始までのタイミング
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# コンソールアプリケーションの画面サイズ変更を高速にする
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles TRUE
# パスバーを表示
defaults write com.apple.finder ShowPathbar -bool "true"
# タイトルバーのフォントサイズの変更
defaults write com.apple.finder NSTitleBarFontSize 18
# Finderのタイトルバーにフルパスを表示
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# "Finder を終了"を表示
defaults write com.apple.Finder QuitMenuItem -bool true
# Quick Lookでテキストを選択できるようにする
defaults write com.apple.finder QLEnableTextSelection -bool true
# ヘルプウィンドウが後ろに隠れるようにする
defaults write com.apple.helpviewer DevMode -bool true
# 「ライブラリ」を常に表示
chflags nohidden ~/Library
## スクリーンショットをjpgで保存
defaults write com.apple.screencapture type jpg
# Finderの再起動
killall Finder

#
# Feedback
#

# フィードバックを送信しない
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"
# クラッシュレポート無効化
defaults write com.apple.CrashReporter DialogType -string "none"

#
# .DS_Store
#

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool "true"

#
# Battery
#

# バッテリーを%表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

#
# Trackpad
#

# タップでクリック
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool "true"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool "true"
defaults -currentHost write -g com.apple.mouse.tapBehavior -bool "true"
# 軌跡の速さ
defaults write -g com.apple.trackpad.scaling 3
## 三本指でドラッグ
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool "true" && \
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool "true"

#
# Mouse
#

# 軌跡の速さ
defaults write -g com.apple.mouse.scaling 3
# スクロールの速さ
defaults write -g com.apple.scrollwheel.scaling 5

#
# Keyboard
#

# キーのリピート速度
defaults write NSGlobalDomain KeyRepeat -int 2
# キーのリピート認識時間
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# フルキーボードアクセスを有効化
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# 本体キーボードのCapsLockキーの動作をControlにリマップ
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
	    <integer>30064771300</integer>\
	      <key>HIDKeyboardModifierMappingSrc</key>\
	        <integer>30064771129</integer>\
		</dict>
  "

#
# Security
#

# ファイアウォールon
sudo defaults write /Library/Preferences/com.Apple.alf globalstate -int 1

#
# Preview
#

# 起動時に前回開いたウィンドウを開かない
defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false

# Others
## GoogleのパブリックDNSを使用する
networksetup -setdnsservers Wi-Fi 2001:4860:4860::8844 2001:4860:4860::8888 8.8.4.4 8.8.8.8
## 自動で頭文字を大文字にしない
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool "false"
# 「前の入力ソースを選択」をオフにする
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"

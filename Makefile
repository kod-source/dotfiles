help: ## この文章を表示します。
	# http://postd.cc/auto-documented-makefile/
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: ## パッケージをインストールします。
	ROLE=all ./install.sh

.PHONY: install_base
install_base: ## ベースパッケージをインストールします。
	ROLE=base ./install.sh

.PHONY: install_cookbooks
install_cookbooks: ## クックブックのパッケージをインストールします。
	ROLE=cookbooks ./install.sh

.PHONY: install_packages
install_packages: ## brewパッケージをインストールします。
	ROLE=packages ./install.sh

.PHONY: install_app
install_app: ## 必要なデスクトップAppをインストールします。
	ROLE=app ./install.sh

.PHONY: install_android
install_android: ## AndroidStudioをインストールします。
	ROLE=android ./install.sh

.PHONY: mac
mac: ## macの設定同期
	./mac/setup.sh

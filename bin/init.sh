#!/bin/sh
set -u

xcode_setup() {
	if [ "$(uname)" = 'Darwin' ]; then
		xcode-select -p
		status=$?
		if ! test $status -eq 0; then
			xcode-select --install
		fi
	fi
}

mitamae_setup() {
	version='1.12.1'
	mitamae_version="mitamae-${version}"

	if ! [ -f "bin/${mitamae_version}" ]; then
		case "$(uname)" in
			"Darwin")
				mitamae_os="darwin"
				;;
			*)
				echo "unknown uname: $(uname)"
				exit 1
				;;
		esac

		case "$(uname -m)" in
			"x86_64")
				mitamae_arch="x86_64"
				;;
			"arm64")
				mitamae_arch="aarch64"
				;;
			*)
				echo "unsupported architecture: $(uname -m)"
				exit 1
				;;
		esac
		mitamae_bin="mitamae-${mitamae_arch}-${mitamae_os}"

		# http://www.hcn.zaq.ne.jp/___/unix/curl_manual.html
		curl -o "bin/${mitamae_bin}.tar.gz" -fL "https://github.com/itamae-kitchen/mitamae/releases/download/v${version}/${mitamae_bin}.tar.gz"
		tar xvzf "bin/${mitamae_bin}.tar.gz"

		rm "bin/${mitamae_bin}.tar.gz"
		mv "${mitamae_bin}" "bin/${mitamae_version}"
		chmod +x "bin/${mitamae_version}"
		ln -sf "${mitamae_version}" bin/mitamae

	else
		echo 'already installed Mitamae'
	fi
}

create_conifg() {
	if [ ! -d "$HOME/.config" ]; then
        mkdir -p "$HOME/.config"
    fi
}

create_conifg
xcode_setup
mitamae_setup

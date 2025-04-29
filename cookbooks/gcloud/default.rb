# install Google Cloud CLI
# https://cloud.google.com/sdk/docs/install

execute "Install Google Cloud SDK" do
  command <<-EOC
    if [ ! -d "$HOME/google-cloud-sdk" ]; then
      curl https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir=$HOME
      echo 'Installed Google Cloud SDK'
    else
      echo 'Google Cloud SDK is already installed'
    fi
  EOC
  not_if "test -d $HOME/google-cloud-sdk"
end

# fishシェル用の設定
execute "Setup for fish shell" do
  command <<-EOC
    if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ] && [ ! -f "$HOME/.config/fish/conf.d/gcloud.fish" ]; then
      echo 'if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end' > "$HOME/.config/fish/conf.d/gcloud.fish"
    fi
  EOC
  only_if "test -d $HOME/google-cloud-sdk"
end

# zsh用の設定
execute "Setup for zsh shell" do
  command <<-EOC
    if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && ! grep -q "source.*google-cloud-sdk/path.zsh.inc" "$HOME/.zshrc"; then
      echo '# The next line updates PATH for the Google Cloud SDK.' >> "$HOME/.zshrc"
      echo 'if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi' >> "$HOME/.zshrc"
      echo '# The next line enables shell command completion for gcloud.' >> "$HOME/.zshrc"
      echo 'if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi' >> "$HOME/.zshrc"
    fi
  EOC
  only_if "test -d $HOME/google-cloud-sdk"
end

# GCPコンポーネントのインストール
gcloud_components = [
  'gke-gcloud-auth-plugin'
]

gcloud_components.each do |component|
  execute "Install gcloud component: #{component}" do
    command <<-EOC
      export PATH="$HOME/google-cloud-sdk/bin:$PATH"
      if "$HOME/google-cloud-sdk/bin/gcloud" components list --format='value(state)' --filter="id=#{component}" | grep -q "Not Installed"; then
        yes | "$HOME/google-cloud-sdk/bin/gcloud" components install #{component}
        echo "Installed gcloud component: #{component}"
      else
        echo "gcloud component #{component} is already installed"
      fi
    EOC
    only_if "test -d $HOME/google-cloud-sdk/bin"
  end
end

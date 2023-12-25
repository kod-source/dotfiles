execute 'Install Rosetta 2' do
  user node[:user]
  command <<-EOC
    if [[ "$(uname -m)" == "arm64" ]]; then
      /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    else
      echo "Rosetta 2 can only be installed on Apple Silicon Macs."
    fi
  EOC
end

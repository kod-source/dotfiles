# preinstallのzshを使います
# package "zsh"

homebrew_bin = ''
case node[:arch]
when 'x86_64'
  homebrew_bin = '/usr/local/bin'
when 'arm64'
  homebrew_bin = '/opt/homebrew/bin'
else
  raise ArgumentError, "unknown arch: #{node[:arch]}"
end

link File.expand_path("#{ENV['HOME']}/.zprofile") do
  to File.expand_path('../templates/zprofile.sh', __FILE__)
  force true
end

link File.expand_path("#{ENV['HOME']}/.zshrc") do
  to File.expand_path('../templates/zshrc.sh', __FILE__)
  force true
end

link File.expand_path("#{ENV['HOME']}/.alias.zsh") do
  to File.expand_path('../templates/alias.sh', __FILE__)
  force true
end

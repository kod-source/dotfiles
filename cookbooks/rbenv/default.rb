package "rbenv"
version = '3.2.0'

# rbenvの環境変数設定
execute 'add rbenv path' do
  not_if 'source ~/.zshrc && which rbenv'
  command <<-EOC
    echo 'export RBENV_ROOT=~/.rbenv' >> ~/.zshrc
    echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
  EOC
end

execute 'install ruby' do
  command <<-EOC
    rbenv install #{version}
    rbenv global #{version}
  EOC
  not_if "rbenv versions | grep #{version}"
end

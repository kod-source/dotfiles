node.reverse_merge!(
  rbenv: {
    user: node[:user],
    global: '3.2.0',
    versions: %w('2.7.7' '3.2.0'),
  }
)

include_recipe "rbenv::user"

# rbenvの環境変数設定
execute 'add rbenv path' do
  not_if 'source ~/.zshrc && which rbenv'
  command <<-EOC
    echo 'export RBENV_ROOT=~/.rbenv' >> ~/.zshrc
    echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
  EOC
end

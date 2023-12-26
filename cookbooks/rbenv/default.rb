package "rbenv"
version = '3.2.0'

execute 'install ruby' do
  command <<-EOC
    rbenv install #{version}
    rbenv global #{version}
  EOC
  not_if "rbenv versions | grep -q #{version}"
end

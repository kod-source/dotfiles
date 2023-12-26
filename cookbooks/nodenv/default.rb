package 'nodenv'
version = '20.0.0'

execute 'install node' do
    command <<-EOC
        nodenv install #{version}
        nodenv global #{version}
    EOC
    not_if "nodenv versions | grep #{version}"
end

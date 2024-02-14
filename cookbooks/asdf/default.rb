package 'gpg'
package 'asdf'

[
    'ruby https://github.com/asdf-vm/asdf-ruby.git',
    'golang https://github.com/asdf-community/asdf-golang.git',
    'nodejs https://github.com/asdf-vm/asdf-nodejs.git'
].each do |pkg|
    name, url = pkg.split
    execute "asdf plugin add #{name}" do
        command "asdf plugin add #{name} #{url}"
        not_if "asdf plugin list | grep -q #{name}"
    end
end

[
    'ruby',
    'golang',
    'nodejs'
].each do |pkg|
    execute "asdf install #{pkg} latest" do
        command <<-EOC
            VERSION=$(asdf latest #{pkg})
            asdf install #{pkg} $VERSION
            asdf global #{pkg} $VERSION
        EOC
    end
end

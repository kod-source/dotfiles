execute "install" do
    command <<-EOC
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
        mkdir -p ~/.config/fish/completions; ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
        echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
        echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
        sh ~/.asdf/asdf.sh
    EOC
    not_if { ::File.exist?(File.expand_path("~/.asdf")) }
end

link File.expand_path("#{ENV['HOME']}/.tool-versions") do
    to File.expand_path('../templates/.tool-versions', __FILE__)
    force true
end

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

execute "install asdf" do
    command <<-EOC
        asdf install
    EOC
end

File.open("#{ENV['HOME']}/.tool-versions") do |file|
    file.each_line do |line|
        pkg, version = line.split
        execute "asdf global #{pkg} #{version}" do
            command "asdf global #{pkg} #{version}"
        end
    end
end

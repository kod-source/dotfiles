package 'fish'
fish_path = '/opt/homebrew/bin/fish'

execute "create folder" do
    command <<-EOC
        if [ ! -d ""#{ENV['HOME']}/.config/fish/conf.d"" ]; then
            mkdir -p "#{ENV['HOME']}/.config/fish/conf.d"
        fi
    EOC
end

execute "echo #{fish_path} | sudo tee -a /etc/shells" do
    not_if "grep #{fish_path} /etc/shells"
end

execute "chsh -s #{fish_path}" do
    not_if { `dscl localhost -read Local/Default/Users/#{node[:user]} UserShell`.include?(fish_path) }
end

execute 'curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish' do
    not_if "test -f #{ENV['HOME']}/.config/fish/functions/fisher.fish"
end

[
    'jethrokuan/z',
    'takashabe/fish-peco',
    'oh-my-fish/theme-bobthefish',
    'oh-my-fish/plugin-peco',
    '0rax/fish-bd',
    'jethrokuan/fzf',
    'oh-my-fish/plugin-balias',
    'oh-my-fish/plugin-expand',
    'jorgebucaran/fish-bax',
    'edc/bass',
    'sijad/gitignore',
].each do |pkg|
    execute "Fisher Install #{pkg}" do
        command "fish -c 'fisher install #{pkg}'"
        not_if "fish -c 'fisher list | grep -q #{pkg}'"
    end
end

Dir.glob(File.expand_path('../templates/**/*', __FILE__)).each do |template_file|
    next if File.directory?(template_file)

    link File.join(ENV['HOME'], '.config', 'fish', template_file.gsub(File.expand_path('../templates', __FILE__), '')) do
        to template_file
        force true
    end
end

link File.expand_path("#{ENV['HOME']}/.config/fish/.gabbr.config") do
    to File.expand_path('../templates/.gabbr.config', __FILE__)
    force true
end

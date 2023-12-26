package 'fish'
fish_path = '/opt/homebrew/bin/fish'

execute "echo #{fish_path} | sudo tee -a /etc/shells" do
    not_if "grep #{fish_path} /etc/shells"
end

# execute "chsh -s #{fish_path}" do
#     not_if { `dscl localhost -read Local/Default/Users/#{node[:user]} UserShell`.include?(fish_path) }
# end

execute 'curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish' do
    not_if "test -f #{ENV['HOME']}/.config/fish/functions/fisher.fish"
end

Dir.glob(File.expand_path('../templates/**/*', __FILE__)).each do |template_file|
    next if File.directory?(template_file)

    link File.join(ENV['HOME'], '.config', 'fish', template_file.gsub(File.expand_path('../templates', __FILE__), '')) do
        to template_file
        force true
    end
end

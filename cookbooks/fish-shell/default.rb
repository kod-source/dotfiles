package 'fish'

# template "#{ENV['HOME']}/.config/fish/config.fish" do
#     source "templates/config.fish"
# end
Dir.glob(File.expand_path('templates/**/*')).each do |src_file|
    next unless File.file?(src_file)  # Skip directories
    dest_file = File.join(ENV['HOME'], '.config', 'fish', File.relative_path('templates', src_file))
    directory File.dirname(dest_file) do
        action :create
        recursive true
    end

    template dest_file do
        source src_file
    end
end


execute "install fisherman" do
    command "echo \"curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher\" | fish"
end

execute "install and apply bobthefish theme" do
    command "echo \"fisher install oh-my-fish/theme-bobthefish\" | fish"
end

execute "install and apply bass" do
    command "echo \"fisher install edc/bass\" | fish"
end

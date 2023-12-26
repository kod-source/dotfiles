package 'gh'

execute "create gh folder" do
    command <<-EOC
        if [ ! -d "#{ENV['HOME']}/.config/gh" ]; then
            mkdir -p "#{ENV['HOME']}/.config/gh"
        fi
    EOC
end

link File.expand_path("#{ENV['HOME']}/.config/gh/config.yml") do
    to File.expand_path('../templates/config.yml', __FILE__)
    force true
end

[
    'seachicken/gh-poi',
    'yusukebe/gh-markdown-preview',
    'vilmibm/gh-user-status'
].each do |pkg|
    execute "Install #{pkg}" do
        command "gh extension install #{pkg}"
        not_if "gh extension list | grep #{pkg}"
    end
end

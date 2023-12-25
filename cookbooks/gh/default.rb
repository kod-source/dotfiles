package 'gh'

execute "create gh folder" do
    command <<-EOC
        if [ ! -d "#{ENV['HOME']}/.config/gh" ]; then
            mkdir -p "#{ENV['HOME']}/.config/gh"
        fi
    EOC
end

template "#{ENV['HOME']}/.config/gh/config.yml" do
    source "templates/config.yml"
end

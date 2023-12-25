darwin_app 'visual-studio-code'

execute "create supoort folder" do
  command <<-EOC
    if [ ! -d "#{ENV['HOME']}/Library/Application Support/Code/User" ]; then
        mkdir -p "#{ENV['HOME']}/Library/Application\ Support/Code/User"
    fi
  EOC
end


template "#{ENV['HOME']}/Library/Application Support/Code/User/settings.json" do
  source "templates/settings.json"
end

template "#{ENV['HOME']}/Library/Application Support/Code/User/keybindings.json" do
  source "templates/keybindings.json"
end

cookbook_dir = File.dirname(__FILE__)
execute "install extensions" do
  command <<-EOC
    if [ -x "$(command -v code)" ]; then
        cat < "#{cookbook_dir}/templates/extensions" | while read -r line
        do
            code --install-extension "$line"
        done

        code --list-extensions > "#{cookbook_dir}/templates/extensions"
    else
        echo "VSCode is not installed."
    fi
  EOC
end

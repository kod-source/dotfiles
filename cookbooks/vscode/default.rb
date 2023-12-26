# darwin_app 'visual-studio-code'

execute "create supoort folder" do
  command <<-EOC
    if [ ! -d "#{ENV['HOME']}/Library/Application Support/Code/User" ]; then
        mkdir -p "#{ENV['HOME']}/Library/Application\ Support/Code/User"
    fi
  EOC
end

link File.expand_path("#{ENV['HOME']}/Library/Application Support/Code/User/settings.json") do
  to File.expand_path('../templates/settings.json', __FILE__)
  force true
end

link File.expand_path("#{ENV['HOME']}/Library/Application Support/Code/User/keybindings.json") do
  to File.expand_path('../templates/keybindings.json', __FILE__)
  force true
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

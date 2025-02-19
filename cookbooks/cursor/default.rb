darwin_app 'cursor'

execute "create supoort folder" do
  command <<-EOC
    if [ ! -d "#{ENV['HOME']}/Library/Application Support/Cursor/User" ]; then
        mkdir -p "#{ENV['HOME']}/Library/Application\ Support/Cursor/User"
    fi
  EOC
end

link File.expand_path("#{ENV['HOME']}/Library/Application Support/Cursor/User/settings.json") do
  to File.expand_path('../templates/settings.json', __FILE__)
  force true
end

link File.expand_path("#{ENV['HOME']}/Library/Application Support/Cursor/User/keybindings.json") do
  to File.expand_path('../templates/keybindings.json', __FILE__)
  force true
end

cookbook_dir = File.dirname(__FILE__)
execute "install extensions" do
  command <<-EOC
    if [ -x "$(command -v cursor)" ]; then
        cat < "#{cookbook_dir}/templates/extensions" | while read -r line
        do
            cursor --install-extension "$line"
        done

        cursor --list-extensions > "#{cookbook_dir}/templates/extensions"
    else
        echo "Cursor is not installed."
    fi
  EOC
end

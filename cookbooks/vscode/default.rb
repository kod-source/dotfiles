darwin_app 'visual-studio-code'

template "#{ENV['HOME']}/Library/Application\ Support/Code/user/settings.json" do
  source "templates/settings.json"
end

template "#{ENV['HOME']}/Library/Application\ Support/Code/user/keybindings.json" do
  source "templates/keybindings.json"
end

execute "install extensions" do
  command <<-EOC
    if [ -x "$(command -v code)" ]; then
        cat < "templates/extensions" | while read -r line
        do
            code --install-extension "$line"
        done

        code --list-extensions > "templates/extensions"
    else
        echo "VSCode is not installed."
    fi
  EOC
end

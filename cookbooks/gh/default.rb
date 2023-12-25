package 'gh'

template "#{ENV['HOME']}/.config/gh/config.yml" do
    source "templates/config.yml"
end

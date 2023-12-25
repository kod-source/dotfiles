package 'tmux'

template "#{ENV['HOME']}/.tmux.conf" do
    source "templates/.tmux.conf"
end

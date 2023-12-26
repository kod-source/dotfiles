package 'tmux'

link File.expand_path("#{ENV['HOME']}/.tmux.conf") do
    to File.expand_path('../templates/.tmux.conf', __FILE__)
    force true
end

package 'vim'

link File.expand_path("#{ENV['HOME']}/.vimrc") do
    to File.expand_path('../templates/.vimrc', __FILE__)
    force true
end

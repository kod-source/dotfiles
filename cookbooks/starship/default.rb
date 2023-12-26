package 'starship'

link File.expand_path("#{ENV['HOME']}/.config/starship.toml") do
    to File.expand_path('../templates/starship.toml', __FILE__)
    force true
end

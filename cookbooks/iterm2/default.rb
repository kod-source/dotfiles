darwin_app 'iterm2'

link File.expand_path("#{ENV['HOME']}/Library/Preferences/com.googlecode.iterm2.plist") do
    to File.expand_path('../templates/com.googlecode.iterm2.plist', __FILE__)
    force true
end

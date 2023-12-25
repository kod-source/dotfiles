darwin_app 'iterm2'

template "#{ENV['HOME']}/Library/Preferences/com.googlecode.iterm2.plist" do
    source "templates/com.googlecode.iterm2.plist"
end

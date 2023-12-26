darwin_app 'rectangle'

link File.expand_path("#{ENV['HOME']}/Library/Preferences/com.knollsoft.Rectangle.plist") do
    to File.expand_path('../templates/com.knollsoft.Rectangle.plist', __FILE__)
    force true
end

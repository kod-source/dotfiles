# darwin_app 'karabiner-elements'

execute "create folder" do
    command <<-EOC
        if [ ! -d ""#{ENV['HOME']}/.config/karabiner/assets/complex_modifications"" ]; then
            mkdir -p "#{ENV['HOME']}/.config/karabiner/assets/complex_modifications"
        fi
    EOC
end

Dir.glob(File.expand_path('../templates/**/*', __FILE__)).each do |template_file|
    next if File.directory?(template_file)

    link File.join(ENV['HOME'], '.config', 'karabiner', template_file.gsub(File.expand_path('../templates', __FILE__), '')) do
        to template_file
        force true
    end
end

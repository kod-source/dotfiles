darwin_app 'alfred'

Dir.glob(File.expand_path('../templates/**/*', __FILE__)).each do |template_file|
    next if File.directory?(template_file)

    link File.join(ENV['HOME'], 'Library', 'Application Support', 'Alfred', 'Alfred.alfredpreferences', template_file.gsub(File.expand_path('../templates', __FILE__), '')) do
        to template_file
        force true
    end
end

darwin_app 'alfred'

Dir.glob(File.expand_path('templates/**/*')).each do |src_file|
    next unless File.file?(src_file)  # Skip directories
    dest_file = File.join(ENV['HOME'], 'Library', 'Application\ Support', 'Alfred', 'Alfred.alfredpreferences', File.relative_path('templates', src_file))
    directory File.dirname(dest_file) do
        action :create
        recursive true
    end

    template dest_file do
        source src_file
    end
end

~/Library/Application\ Support/Alfred

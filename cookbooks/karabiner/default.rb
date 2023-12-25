darwin_app 'karabiner-elements'


Dir.glob(File.expand_path('templates/**/*')).each do |src_file|
    next unless File.file?(src_file)  # Skip directories
    dest_file = File.join(ENV['HOME'], '.config', 'karabiner', File.relative_path('templates', src_file))
    directory File.dirname(dest_file) do
        action :create
        recursive true
    end

    template dest_file do
        source src_file
    end
end

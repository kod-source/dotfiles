darwin_app 'alfred'

Dir.glob(File.expand_path('../templates/**/*', __FILE__)).each do |template_file|
    next if File.directory?(template_file)

    target_dir = File.join(ENV['HOME'], 'Library', 'Application Support', 'Alfred', 'Alfred.alfredpreferences', File.dirname(template_file.gsub(File.expand_path('../templates', __FILE__), '')))

    # ディレクトリが存在しない場合は作成
    unless File.directory?(target_dir)
        system("mkdir -p #{target_dir}")
    end

    target_file = File.join(target_dir, File.basename(template_file))

    # リンク先のディレクトリが存在しない場合は作成
    target_file_dir = File.dirname(target_file)
    unless File.directory?(target_file_dir)
        system("mkdir -p #{target_file_dir}")
    end

    # シンボリックリンクを作成
    system("ln -sfn #{template_file} #{target_file}")
end

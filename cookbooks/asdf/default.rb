package 'asdf'

link File.expand_path("#{ENV['HOME']}/.tool-versions") do
    to File.expand_path('../templates/.tool-versions', __FILE__)
    force true
end

execute "install asdf" do
    command <<-EOC
        asdf install
    EOC
end

File.open("#{ENV['HOME']}/.tool-versions") do |file|
    file.each_line do |line|
        pkg, version = line.split
        execute "asdf global #{pkg} #{version}" do
            command "asdf global #{pkg} #{version}"
        end
    end
end

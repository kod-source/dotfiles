darwin_app 'karabiner-elements'


link File.expand_path("#{ENV['HOME']}/.config/karabiner/karabiner.json") do
    to File.expand_path('../templates/karabiner.json', __FILE__)
    force true
end

# Dir.glob(File.expand_path('templates/**/*')).each do |src_file|
#     next unless File.file?(src_file)  # Skip directories
#     dest_file = File.join(ENV['HOME'], '.config', 'karabiner', File.relative_path('templates', src_file))
#     directory File.dirname(dest_file) do
#         action :create
#         recursive true
#     end

#     template dest_file do
#         source src_file
#     end
# end

# template "#{ENV['HOME']}/.config/karabiner/karabiner.json" do
#     source "templates/karabiner.json"
# end

# template "#{ENV['HOME']}/.config/karabiner/assets/complex_modifications/1648355185.json" do
#     source "templates/1648355185.json"
# end
# template "#{ENV['HOME']}/.config/karabiner/assets/complex_modifications/setting.json" do
#     source "templates/setting.json"
# end
# template "#{ENV['HOME']}/.config/karabiner/assets/complex_modifications/vim.json" do
#     source "templates/vim.json"
# end

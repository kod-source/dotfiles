include_recipe 'recipe_helper'
node.reverse_merge!(
	user: ENV['SUDO_USER'] || ENV['USER'],
	role: ENV['ROLE'] || 'base',
	arch: run_command('uname -m').stdout.chomp,
)
include_role node[:role]

include_recipe 'postgresql::client'

node.default['python']['version'] = '3.4.2'
node.default['python']['checksum'] = '44a3c1ef1c7ca3e4fd25242af80ed72da941203cb4ed1a8c1b724d9078965dd8'
include_recipe 'python::source'

root_path = ::File.join('/home', node['taiga']['user'], 'taiga-front')
directory root_path do
  owner node['taiga']['user']
  group node['taiga']['group']
  recursive true
  not_if { ::Dir.exist?(root_path) }
end

git root_path do
  repository node['taiga']['back']['git_url']
  reference node['taiga']['back']['git_ref']
  user node['taiga']['user']
  group node['taiga']['group']
  action :checkout
end

directory ::File.join(root_path, 'settings') do
  owner node['taiga']['user']
  group node['taiga']['group']
  recursive true
  not_if { ::Dir.exist?(::File.join(root_path, 'settings')) }
end

python_virtualenv root_path do
  interpreter 'python3.4'
  owner node['taiga']['user']
  group node['taiga']['group']
end

python_pip '-r requirements.txt' do
  virtualenv root_path
  owner node['taiga']['user']
  group node['taiga']['group']
end

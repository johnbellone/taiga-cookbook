#
# Cookbook Name:: taiga
# Recipe:: frontend
# License:: Apache 2.0 (see http://www.apache.org/licenses/LICENSE-2.0)
#
include_recipe 'nodejs::default'

nodejs_npm 'bower'
nodejs_npm 'gulp'
nodejs_npm 'sass'
nodejs_npm 'scss-lint'

root_path = ::File.join('/home', node['taiga']['user'], 'taiga-front')
directory root_path do
  owner node['taiga']['user']
  group node['taiga']['group']
  recursive true
  not_if { ::Dir.exist?(root_path) }
end

git root_path do
  repository node['taiga']['front']['git_url']
  reference node['taiga']['front']['git_ref']
  user node['taiga']['user']
  group node['taiga']['group']
  action :checkout
end

directory ::File.join(root_path, 'conf') do
  owner node['taiga']['user']
  group node['taiga']['group']
  recursive true
  not_if { ::Dir.exist?(::File.join(root_path, 'conf')) }
end

# TODO: Write out the conf/main.json file for configuration.

execute 'npm install' do
  cwd root_path
  user node['taiga']['user']
end

execute 'bower install' do
  cwd root_path
  user node['taiga']['user']
end

execute 'gulp deploy' do
  cwd root_path
  user node['taiga']['user']
end

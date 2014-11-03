#
# Cookbook Name:: taiga
# Recipe:: default
# License:: Apache 2.0 (see http://www.apache.org/licenses/LICENSE-2.0)
#
include_recipe 'chef-sugar::default'

group node['taiga']['group'] do
  system true
end

user node['taiga']['user'] do
  gid node['taiga']['group']
end

include_recipe 'python::default'
include_recipe 'postgresql::client'

include_recipe 'nodejs::default'
nodejs_npm 'bower'

# Install and configure Ruby on this instance. This includes the
# common gems that are necessary to run the application.
node.default['ruby-install']['git_ref'] = 'v0.5.0'
include_recipe 'ruby-install::default'

ruby_install_ruby 'ruby 2.1' do
  gems [ { name: 'bundler' }, { name: 'puma'}, { name: 'redis'} ]
end

# Configure a local Redis Sentinel client which will manage
# connections to multiple, highly-available Redis servers.
node.default['redisio']['servers'] = []
include_recipe 'redisio::sentinel'
include_recipe 'redisio::sentinel_enable'

directory node['taiga']['front']['path'] do
  owner node['taiga']['user']
  group node['taiga']['group']
  recursive true
  not_if { ::Dir.exist?(node['taiga']['front']['path']) }
end

git node['taiga']['front']['path'] do
  repository node['taiga']['front']['git_url']
  reference node['taiga']['front']['git_ref']
  user node['taiga']['user']
  group node['taiga']['group']
  action :checkout
end

nodejs_npm 'taiga-front' do
  path node['taiga']['front']['path']
  json true
end

directory node['taiga']['back']['path'] do
  owner node['taiga']['user']
  group node['taiga']['group']
  recursive true
  not_if { ::Dir.exist?(node['taiga']['back']['path']) }
end

git node['taiga']['back']['path'] do
  repository node['taiga']['back']['git_url']
  reference node['taiga']['back']['git_ref']
  user node['taiga']['user']
  group node['taiga']['group']
  action :checkout
end

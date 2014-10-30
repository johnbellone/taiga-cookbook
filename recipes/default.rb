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
  system true
end

include_recipe 'python::default'
include_recipe 'nodejs::default'
include_recipe 'postgresql::client'

# Install and configure Ruby on this instance. This includes the
# common gems that are necessary to run the application.
node.default['chruby']['auto_switch'] = false
node.default['chruby']['rubies'] = { node['taiga']['ruby_version'] => true }
node.default['chruby']['default'] = node['taiga']['ruby_version']
include_recipe 'chruby::system'

# Configure a local Redis Sentinel client which will manage
# connections to multiple, highly-available Redis servers.
node.default['redisio']['servers'] = []
include_recipe 'redisio::sentinel'
include_recipe 'redisio::sentinel_enable'

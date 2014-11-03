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

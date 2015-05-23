#
# Cookbook: taiga
# License: Apache 2.0
#
# Copyright 2014, 2015, Bloomberg Finance L.P.
#
include_recipe 'postgresql::client'

node.default['python']['version'] = '3.4.2'
node.default['python']['checksum'] = '44a3c1ef1c7ca3e4fd25242af80ed72da941203cb4ed1a8c1b724d9078965dd8'
include_recipe 'python::source'

artifact = libartifact_file 'taiga-back' do
  artifact_name 'taiga-back'
  artifact_version ''
  owner node['taiga']['service_user']
  group node['taiga']['service_group']
end

directory File.join(artifact.path, 'settings') do
  owner node['taiga']['service_user']
  group node['taiga']['service_group']
end

python_virtualenv artifact.path do
  interpreter 'python3.4'
  owner node['taiga']['service_user']
  group node['taiga']['service_group']
end

python_pip '-r requirements.txt' do
  virtualenv root_path
  owner node['taiga']['service_user']
  group node['taiga']['service_group']
end

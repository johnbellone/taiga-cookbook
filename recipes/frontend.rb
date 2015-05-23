#
# Cookbook: taiga
# License: Apache 2.0
#
# Copyright 2014, 2015, Bloomberg Finance L.P.
#
include_recipe 'nodejs::default'
%w(bower gulp sass scss-lint).each do |name|
  nodejs_npm name
end

artifact = libartifact_file 'taiga-front' do
  artifact_name 'taiga-front'
  artifact_version node['taiga']['source_version']
  owner node['taiga']['service_user']
  group node['taiga']['service_group']
  notifies :run, 'execute[npm install]', :delayed
  notifies :run, 'execute[bower install]', :delayed
  notifies :run, 'execute[gulp deploy]', :delayed
end

directory File.join(artifact.path, 'conf') do
  owner node['taiga']['service_user']
  group node['taiga']['service_group']
end

execute 'npm install' do
  action :nothing
  user node['taiga']['service_user']
end

execute 'bower install' do
  action :nothing
  user node['taiga']['service_user']
end

execute 'gulp install' do
  action :nothing
  user node['taiga']['service_user']
end

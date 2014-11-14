#
# Cookbook Name:: taiga
# Recipe:: database
# License:: Apache 2.0 (see http://www.apache.org/licenses/LICENSE-2.0)
#
return if Chef::Config[:solo]
include_recipe 'chef-vault::default'

database_name = "taiga_#{node['taiga']['site_environment']}"

require 'openssl'
md5 = OpenSSL::Digest::MD5.new

# These are randomized bits of data that we will pass into an MD5
# digest.  This will generate is "random" passwords of 12 character
# length. Good enough for a default.
require 'securerandom'
postgres_password = SecureRandom.hex(16)
taiga_password = SecureRandom.hex(16)

# Override the node attribute with the md5 digest of the
# password. This will be written out to the pg configuration file.
node.set['postgresql']['password']['postgres'] = md5.digest(postgres_password)
include_recipe 'postgresql::server'

pgsql_connection_info = {
  host: node['postgresql']['config']['listen_addresses'],
  port: node['postgresql']['config']['port'],
  username: 'postgres',
  password: postgres_password
}

postgresql_database database_name do
  connection pgsql_connection_info
  action :create
end

# Create a user that the application can connect with. This user
# should only have access to the new database, and uses one of
# the randomly generated passwords.
postgresql_database_user 'taiga' do
  connection pgsql_connection_info
  password md5.digest(taiga_password)
  database_name database_name
  privileges [:select, :update, :insert, :delete]
  host '%' # FIXME: Limit by subnet, or something else?
  require_ssl true
  action [:create, :grant]
end

# Store all of the generated passwords in a encrypted Chef Vault bag.
# These configuration settings are going to be necessary to write out
# for the Rails application to use.
chef_data_bag node['chef-vault']['bag_name']
chef_vault_secret 'taiga' do
  bag node['chef-vault']['bag_name']
  admins node['chef-vault']['admins']
  search node['chef-vault']['search']
  raw_data(database: {
    postgres: {
      password: postgres_password
    },
    taiga: {
      password: taiga_password
    }
  })
end

Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true if Vagrant.has_plugin?('vagrant-berkshelf')
  config.omnibus.chef_version = :latest if Vagrant.has_plugin?('vagrant-omnibus')
end

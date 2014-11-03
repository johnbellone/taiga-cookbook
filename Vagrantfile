Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true if Vagrant.has_plugin?('vagrant-berkshelf')
  config.omnibus.chef_version = :latest if Vagrant.has_plugin?('vagrant-omnibus')
  config.cache.auto_detect = true if Vagrant.has_plugin?('vagrant-cachier')

  config.vm.box = ENV.fetch('VAGRANT_VM_BOX', 'opscode-ubuntu-14.04')

  config.vm.provider :virtualbox do |vb|
    vb.memory = ENV.fetch('VAGRANT_VM_MEMORY', 2048)
    vb.cpus = ENV.fetch('VAGRANT_VM_CPUS', 2)
  end

  config.vm.provider :vmware_fusion do |vw|
    vw.vmx['memsize'] = ENV.fetch('VAGRANT_VM_MEMORY', 2048)
    vw.vmx['numvcpus'] = ENV.fetch('VAGRANT_VM_MEMORY', 2)
  end if Vagrant.has_plugin?('vagrant-vmware-fusion')

  config.vm.define :taiga, primary: true do |guest|
    guest.vm.network :private_network, ip: '33.33.33.10'
    guest.vm.provision :chef_solo do |chef|
      chef.run_list = %w(recipe[taiga::default])
      chef.json = {
        dev_mode: true
      }
    end
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = '2'

fission_owner = (ENV['INITIAL'] == 'true') ? 'vagrant' : 'dev'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise64'
  config.vm.synced_folder '../fission', '/fission', owner: fission_owner

  config.vm.provision 'chef_solo' do |chef|
    chef.cookbooks_path = 'cookbooks/'
    chef.roles_path = '.'
    chef.data_bags_path = '.'
    chef.add_recipe 'vagabond'
    chef.json = {vagabond: { bases: { centos_5: {enabled: false},
                                      debian_6: {enabled: false},
                                      debian_7: { enabled: false} }}}
  end
end

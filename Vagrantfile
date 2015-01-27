# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = '2'

fission_owner = (ENV['INITIAL'] == 'true') ? 'vagrant' : 'dev'

ssh_key_path = 'FISSION_SSH_KEY_PATH'
raise("#{ssh_key_path} must be set to the path of the appropriate ssh key " +
      "to allow vagrant to interact with fission repos on github")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise64'
  config.vm.synced_folder '../fission', '/fission', owner: fission_owner

  # requires vagrant-omnibus plugin
  config.omnibus.chef_version = '11.18.0'

  # ensure the apt-get cache is up to date
  config.vm.provision :shell, :inline => "sudo apt-get update"

  config.vm.provision 'chef_solo' do |chef|
    chef.cookbooks_path = 'cookbooks/'
    chef.roles_path = '.'
    chef.data_bags_path = '.'
    chef.add_recipe 'fission-vagrant'
    chef.json = {
      :fission_vagrant => {
        :ssh_key => File.read(ENV[ssh_key_path])
      },
      :vagabond => {
        :bases => { :centos_5 => { :enabled => false},
          :debian_6 => { :enabled => false},
          :debian_7 => { :enabled => false}
        }
      },
      :postgresql => {
        :enable_pgdg_apt => true,
        :version => '9.3',
        :password => { 'postgres' => 'awfarts' } }
    }
  end
end

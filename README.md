Basic vagrant/chef provisioning configs to create a VM for fission-related testing.

1. Install gems
  `bundle install`
2. Install recommended Vagrant plugins
  `vagrant plugin install vagrant-omnibus vagrant-vbguest`
3. Install cookbooks
  `bundle exec librarian-chef install`
4. Vagrant up and get some coffee
   `vagrant up`

See https://github.com/hw-product/fission/blob/develop/HACKING.md for more info regarding how this repository is used.

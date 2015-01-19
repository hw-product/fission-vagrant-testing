#
# Cookbook Name:: fission-vagrant
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'ruby_build'

ruby_build_ruby '2.1.2' do
  prefix_path '/usr/local'
end

include_recipe 'postgresql::ruby'
include_recipe 'postgresql::server'

package "postgresql-server-dev-#{node[:postgresql][:version]}"

postgresql_connection_info = {
  :host => "127.0.0.1",
  :port => node[:postgresql][:config][:port],
  :username => 'postgres',
  :password => node[:postgresql][:password][:postgres]
}

postgresql_database_user 'fission' do
  connection postgresql_connection_info
  password 'fission-password'
  action :create
end

database 'fission' do
  connection postgresql_connection_info
  provider Chef::Provider::Database::Postgresql
  owner 'fission'
  action  :create
end

directory '/home/vagrant/.ssh' do
  mode 0700
  owner 'vagrant'
  group 'vagrant'
end

file '/home/vagrant/.ssh/id_rsa' do
  content node[:fission_vagrant][:ssh_key]
  mode 0600
  owner 'vagrant'
  group 'vagrant'
end

include_recipe 'vagabond'

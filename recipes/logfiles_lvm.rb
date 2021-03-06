#
# Cookbook Name:: mysql_support
# Recipe:: logfiles_lvm
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'lvm::default'

lvm_volume_group 'logs' do
  physical_volumes [node['mysql_support']['log']['disk']]
  logical_volume 'logfiles' do
    group 'logs'
    size '100%VG'
    filesystem 'ext4'
    mount_point location: node['mysql_support']['log']['mount'], options: 'noatime,data=ordered'
  end
end

directory "#{node['mysql_support']['log']['mount']}/mysql" do
  owner 'mysql'
  group 'mysql'
  mode '0750'
  recursive true
  action :create
end

['bin-logs', 'relay-logs'].each do |dir|
  directory "#{node['mysql_support']['log']['mount']}/mysql/#{dir}" do
    owner 'mysql'
    group 'mysql'
    mode '0750'
    recursive true
    action :create
  end
end

# directory '/logs/mysql/bin-logs' do
#  owner 'mysql'
#  group 'mysql'
#  mode '0750'
#  recursive true
#  action :create
# end

# directory '/logs/mysql/relay-logs' do
#  owner 'mysql'
#  group 'mysql'
#  mode '0750'
#  recursive true
#  action :create
# end

#
# Cookbook Name:: mysql_support
# Recipe:: datafiles
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

if !node['mysql_support']['data']['disk'].nil? && File.exist?(node['mysql_support']['data']['disk'])
  case node['platform']
  when 'redhat', 'centos', 'amazon', 'scientific'
    include_recipe 'mysql_support::datafiles_lvm'
  end
else
  directory node['mysql_support']['data']['mount'] do
    owner 'mysql'
    group 'mysql'
    mode '0750'
    recursive true
    action :create
  end
end

directory "#{node['mysql_support']['data']['mount']}/mysql" do
  owner 'mysql'
  group 'mysql'
  mode '0750'
  recursive true
  action :create
end

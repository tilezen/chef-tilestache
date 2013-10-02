#
# Cookbook Name:: tilestache
# Recipe:: install
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

chef_gem 'json'
require 'json'

include_recipe 'tilestache::service'
include_recipe 'tilestache::gunicorn'

%w(python-gdal python-shapely python-psycopg2).each do |p|
  package p do
    action :install
  end
end

python_pip 'tilestache' do
  action :install
  version "#{node[:tilestache][:version]}"
end

file "#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}" do
  action :create
  owner 'root'
  group "#{node[:tilestache][:user]}"
  mode 0640
  content JSON.pretty_generate(node[:tilestache][:config_file_hash])
  notifies :restart, 'service[tilestache]', :immediately
end

include_recipe 'tilestache::apache'


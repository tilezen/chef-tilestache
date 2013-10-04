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

case node[:platform_family]
when 'ubuntu'
  %w(python-gdal python-shapely python-psycopg2 python-memcache).each do |p|
    package p do
      action :install
    end
  end
when 'rhel'
  %w(gdal-python python-psycopg2 python-memcached).each do |p|
    package p do
      action :install
    end
  end

  python_pip 'Shapely' do
    action :install
  end
end

python_pip 'tilestache' do
  action :install
  version "#{node[:tilestache][:version]}"
end

# NOTE: there is an issue with the following if you run chef under 
#   ruby1.8.7, in that it doesn't support ordered hashes. Since the key
#   retrieval is random, the config file will be regenerated on every 
#   chef run. Please upgrade to ruby1.9.x (I'm looking at you opsworks!)
file "#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}" do
  action :create
  owner 'root'
  group "#{node[:tilestache][:user]}"
  mode 0640
  content JSON.pretty_generate(node[:tilestache][:config_file_hash])
  notifies :restart, 'service[tilestache]', :immediately
end

include_recipe 'tilestache::apache'


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

# dependencies
case node[:platform_family]
when 'debian'
  %w(python-pip python-gdal python-shapely python-psycopg2 python-memcache).each do |p|
    package p do
      action :install
    end
  end
when 'rhel'
  %w(python-pip gdal-python python-psycopg2 python-memcached).each do |p|
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

include_recipe 'tilestache::gunicorn'

# if supervisor, then don't install init service
case node[:tilestache][:init_type]
when 'supervisor'
  include_recipe 'tilestache::supervisor'
when 'runit'
  include_recipe 'tilestache::runit'
when 'sysv'
  include_recipe 'tilestache::service'
end

tilestacherc 'tilestache-config' do
  cookbook node[:tilestache][:config][:cookbook]
  case node[:tilestache][:supervisor]
  when true
    notifies :restart, 'supervisor_service[tilestache]', :delayed
  else
    notifies :restart, 'service[tilestache]', :delayed
  end
end

# NOTE: there is an issue with the following if you run chef under 
#   ruby1.8.7, in that it doesn't support ordered hashes. Since the key
#   retrieval is random, the config file will be regenerated on every 
#   chef run. Please upgrade to ruby1.9.x (I'm looking at you opsworks!)
#file "#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}" do
#  action :create
#  owner 'root'
#  group "#{node[:tilestache][:group]}"
#  mode 0640
#  content JSON.pretty_generate(node[:tilestache][:config_file_hash])
#  case node[:tilestache][:supervisor]
#  when true
#    notifies :restart, 'supervisor_service[tilestache]', :delayed
#  else
#    notifies :restart, 'service[tilestache]', :delayed
#  end
#end

include_recipe 'tilestache::apache'


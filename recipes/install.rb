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
#
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

case node[:tilestache][:install_method]
when 'pip'
  python_pip 'tilestache' do
    action :install
    version node[:tilestache][:version]
  end
when 'git'
  bash 'install-tilestache-source' do
    action :nothing
    code <<-EOH
      cd "#{node[:tilestache][:source_install_dir]}"
      python setup.py install
    EOH
  end

  git node[:tilestache][:source_install_dir do
    repository node[:tilestache][:git_repository]
    reference node[:app_name][:git_revision]
    action :sync
    notifies :run, 'bash[install-tilestache-source]'
  end
end

include_recipe 'tilestache::gunicorn'

# if supervisor, then don't install init service
#
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

include_recipe 'tilestache::apache'

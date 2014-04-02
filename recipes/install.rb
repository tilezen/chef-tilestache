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
%w(
  python-pip
  python-gdal
  python-shapely
  python-psycopg2
  python-memcache
  python-redis
  python-modestmaps
  python-protobuf
).each do |p|
  package p do
    action :install
  end
end

python_pip 'image'

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

  git node[:tilestache][:source_install_dir] do
    repository node[:tilestache][:git_repository]
    reference node[:tilestache][:git_revision]
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

case node[:tilestache][:config][:include]
when true
  tilestache_cfg "#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}" do
    action          :create
    owner           node[:tilestache][:user]
    group           node[:tilestache][:group]
    source_file     node[:tilestache][:config][:source_file]
    source_cookbook node[:tilestache][:config][:source_cookbook]
  end
end
    #cookbook node[:tilestache][:config][:cookbook]
    #if node[:tilestache][:init_type]
    #  case node[:tilestache][:supervisor]
    #  when true
    #    notifies :restart, 'supervisor_service[tilestache]', :delayed
    #  else
    #    notifies :restart, 'service[tilestache]', :delayed
    #  end
    #end
  #end

include_recipe 'tilestache::apache'

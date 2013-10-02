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

package 'python-gdal' do
  action :install
end

python_pip 'tilestache' do
  action :install
  version "#{node[:tilestache][:version]}"
end

file "#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}" do
  action :create
  owner 'root'
  group 'root'
  mode 0644
  content JSON.pretty_generate(node[:tilestache][:config_file_hash])

  # hack for opsworks only supporting 1.8.7 (no ordered hash causes
  #   config file to change on every run, so we'll remove the notify
  #   and log a message that action must be taken manually.
  case node[:languages][:ruby][:version]
  when '1.8.7'
    log 'name' do
      level :warn
      message 'Detected ruby 1.8.7. You will need to manually restart if you have made config file changes that you want to take effect'
    end
  else
    notifies :restart, 'service[tilestache]', :immediately
  end
end

include_recipe 'tilestache::apache'


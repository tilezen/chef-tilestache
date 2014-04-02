#
# Cookbook Name: chef-tilestache
# Provider: tilestacherc
#
# Copyright 2014, Mapzen
#
# LWRP for creating tilestache config file:
#   action:           create or delete (default create)
#   mode:             mode for config file (default: node[:tilestache][:config][:mode])
#   owner:            owner of config file (default: node[:tilestache][:user])
#   group:            group of config file (default: node[:tilestache][:group])
#   source_file:      name of config file located in templates directory (default: node[:tilestache][:config][:source_file])
#   source_cookbook:  cookbook to look for the config file in (default: node[:tilestache][:config][:source_cookbook])
#
# Example usage:
#   tilestache_cfg '/path/to/my/tilestache/cfg' do
#     owner           'some_user'
#     group           'some_group'
#     source_file     'my_tilestache.conf.erb'
#     source_cookbook 'my_tilestache_cookbook'
#   end
#
action :create do
  install_path    = new_resource.install_path     || node[:tilestache][:cfg_path] + node[:tilestache][:cfg_file]
  mode            = new_resource.mode             || node[:tilestache][:config][:mode]
  owner           = new_resource.owner            || node[:tilestache][:user]
  group           = new_resource.group            || node[:tilestache][:group]
  source_file     = new_resource.source_file      || node[:tilestache][:config][:source_file]
  source_cookbook = new_resource.source_cookbook  || node[:tilestache][:config][:source_cookbook]

  template install_path do
    action    :create
    mode      mode
    owner     owner
    group     group
    source    source_file
    cookbook  source_cookbook
  end
end

action :delete do
  template install_path do
    action :delete
  end
end

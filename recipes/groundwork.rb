#
# Cookbook Name:: tilestache
# Recipe:: groundwork
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

user_account "#{node[:tilestache][:user]}" do
  manage_home true
  home '/home/tilestache'
  shell "#{node[:tilestache][:user_shell]}"
  ssh_keygen node[:tilestache][:user_keygen]
  uid node[:tilestache][:uid]
  gid node[:tilestache][:gid]
end

user_ulimit "#{node[:tilestache][:user]}" do
  filehandle_limit "#{node[:tilestache][:filehandle_limit]}"
end

directory "#{node[:tilestache][:cfg_path]}" do
  owner "#{node[:tilestache][:user]}"
  group "#{node[:tilestache][:group]}"
  action :create
end

directories = [
  "#{node[:tilestache][:cfg_path]}",
  "#{node[:tilestache][:gunicorn][:logdir]}",
  "#{node[:tilestache][:gunicorn][:piddir]}"
]
directories.each do |d|
  directory d do
    owner "#{node[:tilestache][:user]}"
    group "#{node[:tilestache][:group]}"
    action :create
  end
end

# logrotate
template '/etc/logrotate.d/tilestache' do
  source 'tilestache-logrotate.erb'
  mode 0644
  owner 'root'
  group 'root'
end


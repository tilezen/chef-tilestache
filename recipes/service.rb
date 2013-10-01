#
# Cookbook Name:: tilestache
# Recipe:: service
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

template '/etc/init.d/tilestache' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  source 'tilestache-init.erb'
end

service 'tilestache' do
  supports :start => true, :stop => true, :restart => true
  action [ :enable ]
end

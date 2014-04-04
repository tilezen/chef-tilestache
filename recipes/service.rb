#
# Cookbook Name:: tilestache
# Recipe:: service
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

template '/etc/init.d/tilestache' do
  owner   'root'
  group   'root'
  source  'tilestache-init.erb'
  mode    0755
end

service 'tilestache' do
  action    [:enable]
  supports  start: true, stop: true, restart: true, status: true
end

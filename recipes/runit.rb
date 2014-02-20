#
# Cookbook Name:: tilestache
# Recipe:: runit
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'runit'

runit_service 'tilestache' do
  finish_script true
  action [:enable, :start]
end


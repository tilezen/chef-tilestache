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
  action          [:enable, :start]
  log             true
  finish          true
  default_logger  true
  sv_timeout      60
end

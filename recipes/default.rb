#
# Cookbook Name:: tilestache
# Recipe:: default
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'

%w(
  git
  tilestache::groundwork
  python::package
).each do |r|
  #python::pip
  include_recipe r
end

include_recipe 'tilestache::install'


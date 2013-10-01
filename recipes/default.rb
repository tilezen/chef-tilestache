#
# Cookbook Name:: tilestache
# Recipe:: default
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

# include apt on debian distros
case node[:platform_family]
when 'debian'
  include_recipe 'apt'
end

%w(
  git
  tilestache::groundwork
  python::package
  python::pip
).each do |r|
  include_recipe r
end

include_recipe 'tilestache::install'

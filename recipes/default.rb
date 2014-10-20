#
# Cookbook Name:: tilestache
# Recipe:: default
#

include_recipe 'apt'

%w(
  git
  tilestache::groundwork
  python::package
).each do |r|
  include_recipe r
end

include_recipe 'tilestache::install'

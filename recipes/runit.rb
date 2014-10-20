#
# Cookbook Name:: tilestache
# Recipe:: runit
#

include_recipe 'runit'

runit_service 'tilestache' do
  action          [:enable, :start]
  log             true
  default_logger  true
  sv_timeout      node[:tilestache][:runit][:svwait]
end

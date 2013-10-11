#
# Cookbook Name:: tilestache
# Recipe:: apache
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

case node[:tilestache][:apache_proxy]
when true
  include_recipe 'apache2'
  include_recipe 'apache2::mod_proxy'
  include_recipe 'apache2::mod_proxy_http'
  include_recipe 'apache2::mod_proxy_connect'

  web_app 'tilestache-proxy' do
    template 'tilestache-proxy.conf.erb'
    server_name node[:tilestache][:apache][:server_name]
    proxy_port node[:tilestache][:gunicorn][:port]
    max node[:tilestache][:apache][:max]
    ttl node[:tilestache][:apache][:ttl]
    retrytimeout node[:tilestache][:apache][:retrytimeout]
    connectiontimeout node[:tilestache][:apache][:connectiontimeout]
    base_uri node[:tilestache][:apache][:base_uri]
  end

  apache_site 'tilestache-proxy' do
    action :enable
  end
end


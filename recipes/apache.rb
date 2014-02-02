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
  #include_recipe 'apache2::mod_proxy'
  #include_recipe 'apache2::mod_expires'
  #include_recipe 'apache2::mod_proxy_http'
  #include_recipe 'apache2::mod_proxy_connect'
 
  %w(default 000-default).each do |site| 
    apache_site site do
      enable false
    end
  end

  %w(proxy expires proxy_http proxy_connect).each do |m|
    apache_module m
  end

  web_app 'tilestache-proxy' do
    template 'tilestache-proxy.conf.erb'
    port              node[:tilestache][:apache][:port]
    proxy_port        node[:tilestache][:gunicorn][:port]
    server_name       node[:tilestache][:apache][:server_name]
    max               node[:tilestache][:apache][:max]
    ttl               node[:tilestache][:apache][:ttl]
    retrytimeout      node[:tilestache][:apache][:retrytimeout]
    connectiontimeout node[:tilestache][:apache][:connectiontimeout]
    requesttimeout    node[:tilestache][:apache][:requesttimeout]
    base_uri          node[:tilestache][:apache][:base_uri]
  end

  apache_site 'tilestache-proxy' do
    action :enable
  end
end


#
# Cookbook Name:: tilestache
# Recipe:: gunicorn
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

python_pip 'gunicorn' do
  action :install
  version "#{node[:tilestache][:gunicorn][:version]}"
end

case node[:tilestache][:gunicorn][:worker_class]
when 'tornado'
  package 'python-tornado' do
    action :install
  end
when 'gevent' do
  package 'python-gevent' do
    action :install
  end
end

gunicorn_config "#{node[:tilestache][:gunicorn][:cfgbasedir]}/#{node[:tilestache][:gunicorn][:cfg_file]}" do
  action :create
  listen              "#{node[:ipaddress]}:#{node[:tilestache][:gunicorn][:port]}"
  pid                 "#{node[:tilestache][:gunicorn][:piddir]}/#{node[:tilestache][:gunicorn][:pidfile]}"
  backlog             node[:tilestache][:gunicorn][:backlog]
  preload_app         node[:tilestache][:gunicorn][:preload]
  worker_max_requests node[:tilestache][:gunicorn][:max_requests]
  worker_processes    node[:tilestache][:gunicorn][:workers]
  worker_keepalive    node[:tilestache][:gunicorn][:keepalive]
  worker_timeout      node[:tilestache][:gunicorn][:timeout]
  worker_class        "#{node[:tilestache][:gunicorn][:worker_class]}"
  case node[:tilestache][:supervisor]
  when true
    notifies :restart, 'supervisor_service[tilestache]', :delayed
  else
    notifies :restart, 'service[tilestache]', :delayed
  end
end

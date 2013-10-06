#
# Cookbook Name:: tilestache
# Recipe:: supervisor
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'supervisor'

supervisor_service 'tilestache' do
  action :enable
  autostart true
  startsecs 5
  stopsignal 'TERM'
  stopwaitsecs 3
  stdout_logfile "#{node[:tilestache][:gunicorn][:logdir]}/#{node[:tilestache][:gunicorn][:logfile]}"
  stderr_logfile "#{node[:tilestache][:gunicorn][:logdir]}/#{node[:tilestache][:gunicorn][:logfile]}"
  directory "#{node[:tilestache][:cfg_path]}"
  command "/usr/local/bin/gunicorn \"TileStache:WSGITileServer('#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}')\" --log-file #{node[:tilestache][:gunicorn][:logdir]}/#{node[:tilestache][:gunicorn][:logfile]} -c #{node[:tilestache][:gunicorn][:cfgbasedir]}/#{node[:tilestache][:gunicorn][:cfg_file]}"
end



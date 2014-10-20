#
# Cookbook Name:: tilestache
# Recipe:: supervisor
#

include_recipe 'supervisor'

service 'tilestache' do
  action :nothing
end

supervisor_service 'tilestache' do
  action          [:enable]
  autostart       true
  startsecs       3
  stopwaitsecs    3
  stopsignal      'TERM'
  user            node[:tilestache][:user]
  stdout_logfile  "#{node[:tilestache][:gunicorn][:logdir]}/supervisor.log"
  stderr_logfile  "#{node[:tilestache][:gunicorn][:logdir]}/supervisor.log"
  directory       node[:tilestache][:cfg_path]
  command         "/usr/local/bin/gunicorn \"TileStache:WSGITileServer('#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}')\" \
--log-file #{node[:tilestache][:gunicorn][:logdir]}/#{node[:tilestache][:gunicorn][:logfile]} \
-c #{node[:tilestache][:gunicorn][:cfgbasedir]}/#{node[:tilestache][:gunicorn][:cfg_file]}"
end

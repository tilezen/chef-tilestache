#
# Cookbook Name:: tilestache
# Recipe:: gunicorn
#

python_pip 'gunicorn' do
  version node[:tilestache][:gunicorn][:version]
end

python_pip 'tornado' do
  version node[:tilestache][:gunicorn][:tornado_version]
  only_if { node[:tilestache][:gunicorn][:worker_class] == 'tornado' }
end

package 'python-gevent' do
  action :install
  only_if { node[:tilestache][:gunicorn][:worker_class] == 'gevent' }
end

gunicorn_config "#{node[:tilestache][:gunicorn][:cfgbasedir]}/#{node[:tilestache][:gunicorn][:cfg_file]}" do
  listen              "#{node[:ipaddress]}:#{node[:tilestache][:gunicorn][:port]}"
  pid                 "#{node[:tilestache][:gunicorn][:piddir]}/#{node[:tilestache][:gunicorn][:pidfile]}"
  backlog             node[:tilestache][:gunicorn][:backlog]
  preload_app         node[:tilestache][:gunicorn][:preload]
  worker_max_requests node[:tilestache][:gunicorn][:max_requests]
  worker_processes    node[:tilestache][:gunicorn][:workers]
  worker_keepalive    node[:tilestache][:gunicorn][:keepalive]
  worker_timeout      node[:tilestache][:gunicorn][:timeout]
  worker_class        node[:tilestache][:gunicorn][:worker_class]

  if node[:tilestache][:init_type]
    case node[:tilestache][:init_type]
    when 'supervisor'
      notifies :restart, 'supervisor_service[tilestache]', :delayed
    when 'runit'
      notifies :restart, 'runit_service[tilestache]', :delayed
    when 'sysv'
      notifies :restart, 'service[tilestache]', :delayed
    end
  end
end

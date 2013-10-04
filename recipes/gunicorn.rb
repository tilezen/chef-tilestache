python_pip 'gunicorn' do
  action :install
  version "#{node[:tilestache][:gunicorn][:version]}"
end

python_pip "#{node[:tilestache][:gunicorn][:worker_class]}" do
  action :install
end

gunicorn_config "#{node[:tilestache][:gunicorn][:cfgbasedir]}/gunicorn.cfg" do
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
  notifies :restart, 'service[tilestache]', :delayed
end

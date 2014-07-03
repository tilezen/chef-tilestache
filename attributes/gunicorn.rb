#
# Cookbook Name:: tilestache
# Attributes:: gunicorn
#

default[:tilestache][:gunicorn][:version]      = '18.0'
default[:tilestache][:gunicorn][:backlog]      = 2048
default[:tilestache][:gunicorn][:keepalive]    = 5
default[:tilestache][:gunicorn][:max_requests] = 0
default[:tilestache][:gunicorn][:pidfile]      = 'gunicorn.pid'
default[:tilestache][:gunicorn][:logdir]       = '/var/log/tilestache'
default[:tilestache][:gunicorn][:piddir]       = "#{node[:tilestache][:gunicorn][:logdir]}/pids"
default[:tilestache][:gunicorn][:logfile]      = 'gunicorn.log'
default[:tilestache][:gunicorn][:port]         = 8000
default[:tilestache][:gunicorn][:timeout]      = 30
default[:tilestache][:gunicorn][:worker_class] = 'sync'
default[:tilestache][:gunicorn][:preload]      = false
default[:tilestache][:gunicorn][:workers]      = (node[:cpu][:total] * 4)
default[:tilestache][:gunicorn][:cfgbasedir]   = '/etc/tilestache'
default[:tilestache][:gunicorn][:cfg_file]     = 'gunicorn.cfg'

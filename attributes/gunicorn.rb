#
# Cookbook Name:: tilestache
# Attributes:: gunicorn
#

default[:tilestache][:gunicorn][:version]            = '17.5'
default[:tilestache][:gunicorn][:backlog]            = 100
default[:tilestache][:gunicorn][:keepalive]          = 60
default[:tilestache][:gunicorn][:max_requests]       = 100
default[:tilestache][:gunicorn][:piddir]             = '/var/run/tilestache'
default[:tilestache][:gunicorn][:pidfile]            = 'gunicorn.pid'
default[:tilestache][:gunicorn][:logdir]             = '/var/log/tilestache'
default[:tilestache][:gunicorn][:logfile]            = 'gunicorn.log'
default[:tilestache][:gunicorn][:port]               = 8000
default[:tilestache][:gunicorn][:timeout]            = 300
default[:tilestache][:gunicorn][:worker_class]       = 'tornado'
default[:tilestache][:gunicorn][:preload]            = false
default[:tilestache][:gunicorn][:workers]            = node.cpu.total
default[:tilestache][:gunicorn][:cfgbasedir]         = '/etc/tilestache'


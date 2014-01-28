#
# Cookbook Name:: tilestache
# Attributes:: apache
#

default[:tilestache][:apache][:server_name]       = 'tilestache'
default[:tilestache][:apache][:port]              = 80
default[:tilestache][:apache][:max]               = 20
default[:tilestache][:apache][:ttl]               = 300
default[:tilestache][:apache][:retrytimeout]      = 3
default[:tilestache][:apache][:connectiontimeout] = 3
default[:tilestache][:apache][:requesttimeout]    = 60
default[:tilestache][:apache][:base_uri]          = '/vector/'
default[:tilestache][:apache][:max_age]           = 43200

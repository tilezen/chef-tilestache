#
# Cookbook Name:: tilestache
# Attributes:: default
#

default[:tilestache][:config][:include]          = true
default[:tilestache][:config][:source_cookbook]  = 'tilestache'
default[:tilestache][:config][:source_file]      = 'tilestache.conf.erb'

default[:tilestache][:init_type]          = 'runit'
default[:tilestache][:version]            = '1.49.8'
default[:tilestache][:filehandle_limit]   = 20_480
default[:tilestache][:cfg_path]           = '/etc/tilestache'
default[:tilestache][:cfg_file]           = 'tilestache.conf'
default[:tilestache][:user]               = 'tilestache'
default[:tilestache][:group]              = 'tilestache'
default[:tilestache][:user_shell]         = '/bin/false'
default[:tilestache][:user_keygen]        = false
default[:tilestache][:apache_proxy]       = true
default[:tilestache][:uid]                = nil
default[:tilestache][:gid]                = nil
default[:tilestache][:install_method]     = 'pip'
default[:tilestache][:git_repository]     = 'https://github.com/mapzen/TileStache.git'
default[:tilestache][:git_revision]       = 'master'
default[:tilestache][:source_install_dir] = '/opt/tilestache_source'

# python
default[:python][:install_method] = 'package'

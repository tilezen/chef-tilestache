# tilestache
default[:tilestache][:version]          = '1.49.8'
default[:tilestache][:filehandle_limit] = 20480
default[:tilestache][:cfg_path]         = '/etc/tilestache'
default[:tilestache][:cfg_file]         = 'tilestache.conf'
default[:tilestache][:user]             = 'tilestache'
default[:tilestache][:group]            = 'tilestache'
default[:tilestache][:user_shell]       = '/bin/false'
default[:tilestache][:user_keygen]      = false
default[:tilestache][:apache_proxy]     = true

# python
default[:python][:install_method] = 'package'

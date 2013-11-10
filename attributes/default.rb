#
# Cookbook Name:: tilestache
# Attributes:: default
#

default[:tilestache][:init_type]        = 'runit'
default[:tilestache][:version]          = '1.49.8'
default[:tilestache][:filehandle_limit] = 20480
default[:tilestache][:cfg_path]         = '/etc/tilestache'
default[:tilestache][:cfg_file]         = 'tilestache.conf'
default[:tilestache][:user]             = 'tilestache'
default[:tilestache][:group]            = 'tilestache'
default[:tilestache][:user_shell]       = '/bin/false'
default[:tilestache][:user_keygen]      = false
default[:tilestache][:apache_proxy]     = true
default[:tilestache][:uid]              = nil
default[:tilestache][:gid]              = nil

# tilestache config file hash
default[:tilestache][:config_file_hash] = {
  "cache" => { "name" => "Test", "verbose" => "true" },
  "provider" => { "name" => "proxy", "url" => "http://tile.openstreetmap.org/{X}/{Y}/{Z}.png" }
}

# python
default[:python][:install_method] = 'package'

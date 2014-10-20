#
# Cookbook Name:: tilestache
# Recipe:: install
#

# dev dependencies required for python packages
%w(
  python-dev
  libgeos-dev
  libpq-dev
).each do |p|
  package p do
    action :install
  end
end

# all installation paths require pip to be installed
package 'python-pip'

# TileStache depends on Pillow/Pil conditionally based on if Pillow is
# already pre-installed. Install Pillow up front to force the Pillow
# dependency to be used.
package 'python-pil'

# if not installing from requirements file, use the debian packages to
# pull in the necessary python package dependencies
%w(
  python-gdal
  python-shapely
  python-psycopg2
  python-memcache
  python-pylibmc
  python-redis
  python-modestmaps
  python-protobuf
).each do |p|
  package p do
    action :install
    not_if { node[:tilestache][:install_method] == 'pip_requirements' }
  end
end

python_pip 'tilestache' do
  version node[:tilestache][:version]
  only_if { node[:tilestache][:install_method] == 'pip' }
end

bash 'install-tilestache-source' do
  action :nothing
  code <<-EOH
    cd "#{node[:tilestache][:source_install_dir]}"
    python setup.py install
  EOH
end

git node[:tilestache][:source_install_dir] do
  action      :sync
  repository  node[:tilestache][:git_repository]
  reference   node[:tilestache][:git_revision]
  notifies    :run, 'bash[install-tilestache-source]'
  only_if { node[:tilestache][:install_method] == 'git' }
end

# if installing from requirements file, all dependencies are assumed
# to come from there, including the TileStache package itself
include_recipe 'tilestache::pip_requirements' if node[:tilestache][:install_method] == 'pip_requirements'

# optionally install gunicorn to support the workflow of only
# installing TileStache itself
include_recipe 'tilestache::gunicorn'   if node[:tilestache][:gunicorn_server] == true

# init type
#
include_recipe 'tilestache::supervisor' if node[:tilestache][:init_type] == 'supervisor'
include_recipe 'tilestache::runit'      if node[:tilestache][:init_type] == 'runit'
include_recipe 'tilestache::service'    if node[:tilestache][:init_type] == 'sysv'

# include a sample tilestache cfg for testing?
#   Override the default of false if so.
#
template "#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}" do
  owner     node[:tilestache][:user]
  group     node[:tilestache][:group]
  source    node[:tilestache][:config][:source_file]
  only_if   { node[:tilestache][:config][:include_sample] == true }

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

# reload: Reload tilestache so it notices the new service.  :delayed (default) or :immediately.
# action: :enable To create the tilestache config (default), or :disable to remove it.
# variables: Hash of instance variables to pass to the ERB template
# template_cookbook: the cookbook in which the configuration resides
# template_source: filename of the ERB configuration template, defaults to <LWRP Name>.conf.erb
define :tilestacherc, reload: :delayed do
  params[:template_source] ||= "#{params[:name]}.conf.erb"
  template "#{node[:tilestache][:cfg_path]}/#{node[:tilestache][:cfg_file]}" do
    owner node[:tilestache][:user]
    group node[:tilestache][:group]
    mode 0644
    source node[:tilestache][:config][:source_file]
    cookbook node[:tilestache][:config][:source_cookbook]
    if node[:tilestache][:init_type]
      notifies :restart, 'service[tilestache]', params[:reload]
    end
    action :create
  end
end

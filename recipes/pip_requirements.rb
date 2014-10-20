#
# Cookbook Name:: tilestache
# Recipe:: pip_requirements
#

template node[:tilestache][:pip_requirements_location] do
  source 'tilestache-pip-requirements.txt.erb'
end

python_pip "-r #{node[:tilestache][:pip_requirements_location]}"

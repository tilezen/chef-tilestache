#
# Cookbook Name:: tilestache
# Recipe:: pip_requirements
#

file node[:tilestache][:pip_requirements_location] do
  content node[:tilestache][:pip_requirements].join("\n")
end

python_pip "-U -r #{node[:tilestache][:pip_requirements_location]}"

require 'spec_helper'

describe 'tilestache::apache' do
  context 'include proxy' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version:  '12.04') do |node|
        node.set[:tilestache][:apache_proxy] = true
      end.converge(described_recipe)
    end

    # NOTE: need to define custom matchers
    #
    #it 'should include recipe apache2::default' do
    #  chef_run.should include_recipe'apache2::default'
    #end

    #it 'should include disable the default apache sites' do
    #  chef_run.should disable_apache_site 'default'
    #  chef_run.should disable_apache_site '000-default'
    #end
  end
end


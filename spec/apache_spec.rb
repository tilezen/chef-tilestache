require 'spec_helper'

describe 'tilestache::apache' do
  context 'include proxy' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:apache_proxy] = true
      end.converge(described_recipe)
    end

    it 'should include recipe apache2::default' do
      chef_run.should include_recipe 'apache2::default'
    end

    %w(proxy expires proxy_http proxy_connect).each do |mod|
      it "should execute a2enmod #{mod}" do
        chef_run.should run_execute "a2enmod #{mod}"
      end
    end

  end
end


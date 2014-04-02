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

  context 'senza proxy' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:apache_proxy] = false
      end.converge(described_recipe)
    end

    it 'should not include recipe apache2::default' do
      chef_run.should_not include_recipe 'apache2::default'
    end
  end

end

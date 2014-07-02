require 'spec_helper'

describe 'tilestache::apache' do
  context 'include proxy' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:apache_proxy]  = true
        node.set[:apache][:dir]               = '/etc/apache'
      end.converge(described_recipe)
    end

    it 'should include recipe apache2::default' do
      expect(chef_run).to include_recipe 'apache2::default'
    end

    %w(proxy expires proxy_http proxy_connect).each do |mod|
      it "should execute a2enmod #{mod}" do
        expect(chef_run).to run_execute "a2enmod #{mod}"
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
      expect(chef_run).to_not include_recipe 'apache2::default'
    end
  end

end

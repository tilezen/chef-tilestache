require 'spec_helper'

describe 'tilestache::runit' do
  let (:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should include recipe runit::default' do
    chef_run.should include_recipe 'runit::default'
  end

  it 'should create the service template' do
    chef_run.should create_template '/etc/sv/tilestache/run'
  end

end

require 'spec_helper'

describe 'tilestache::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should not include the apt::default recipe' do
    expect(chef_run).to_not include_recipe 'tilestache::epel'
  end

  it 'should include the apt::default recipe' do
    expect(chef_run).to include_recipe 'apt::default'
  end

  it 'should include the git::default recipe' do
    expect(chef_run).to include_recipe 'git::default'
  end

  it 'should include the tilestache::groundwork recipe' do
    expect(chef_run).to include_recipe 'tilestache::groundwork'
  end

  it 'should include the python::package recipe' do
    expect(chef_run).to include_recipe 'python::package'
  end

  it 'should include the tilestache::install recipe' do
    expect(chef_run).to include_recipe 'python::package'
  end

end

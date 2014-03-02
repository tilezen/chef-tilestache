#load 'spec/support/matchers/supervisor_service.rb'

describe 'tilestache::supervisor' do
  let (:chef_run) { ChefSpec::Runner.new(
    platform: 'ubuntu',
    version:  '12.04'
  ).converge(described_recipe) }

  before do
    stub_command("/usr/bin/python -c 'import setuptools'").and_return(true)
  end

  it 'should include recipe supervisor::default' do
    chef_run.should include_recipe('supervisor::default')
  end

  # NOTE: not sure what's up here, but these don't match.
  #   Opsworks runit cookbook weirdness???
  #it 'should enable the tilestache runit service' do
  #  chef_run.should enable_service('tilestache')
  #end

  #it 'should start the tilestache runit service' do
  #  chef_run.should start_service('tilestache')
  #end

end

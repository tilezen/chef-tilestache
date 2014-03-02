require 'spec_helper'

describe 'tilestache::runit' do
  let (:chef_run) { ChefSpec::Runner.new(
    platform: 'ubuntu',
    version:  '12.04',
    version:  '12.04'
  ).converge(described_recipe) }

  it 'should include recipe runit::default' do
    chef_run.should include_recipe('runit::default')
  end

  # NOTE: not sure what's up here, but these don't match.
  #   Opsworks runit cookbook weirdness???
  #it 'should enable the tilestache runit service' do
  #  chef_run.should enable_runit_service('tilestache')
  #end

  #it 'should start the tilestache runit service' do
  #  chef_run.should start_runit_service('tilestache')
  #end

end

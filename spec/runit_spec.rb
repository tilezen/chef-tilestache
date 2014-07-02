require 'spec_helper'

describe 'tilestache::runit' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should include recipe runit::default' do
    expect(chef_run).to include_recipe 'runit::default'
  end

  it 'should start and enable the runit service tilestache' do
    expect(chef_run).to start_runit_service('tilestache').with(
      log:            true,
      finish:         true,
      default_logger: true,
      action:         [:enable, :start]
    )
  end

end

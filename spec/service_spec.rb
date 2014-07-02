require 'spec_helper'

describe 'tilestache::service' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should create file from template /etc/init.d/tilestache' do
    expect(chef_run).to create_template('/etc/init.d/tilestache').with(
      owner:  'root',
      group:  'root',
      mode:   0755,
      source: 'tilestache-init.erb'
    )
  end

  it 'should enable the tilestache service' do
    expect(chef_run).to enable_service('tilestache').with(
      supports: { start: true, stop: true, restart: true, status: true }
    )
  end

end

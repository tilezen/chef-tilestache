describe 'tilestache::service' do
  let (:chef_run) { ChefSpec::Runner.new(
    platform: 'ubuntu',
    version:  '12.04'
  ).converge(described_recipe) }

  it 'should create file from template /etc/init.d/tilestache' do
    chef_run.should create_template('/etc/init.d/tilestache').with(owner: 'root', group: 'root', mode: '0755', source: 'tilestache-init.erb')
  end

  it 'should enable the tilestache service' do
    chef_run.should enable_service('tilestache')
  end

end

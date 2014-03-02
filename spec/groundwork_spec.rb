load 'spec/support/matchers/user_account.rb'

describe 'tilestache::groundwork' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version:  '12.04').converge(described_recipe) }

  it 'should create the user tilestache' do
    expect(chef_run).to create_user_account('tilestache')
  end

  it 'should not create the user root' do
    chef_run.node.set[:tilestache][:user] = 'root'
    chef_run.converge(described_recipe)
    expect(chef_run).not_to create_user_account('root')
  end

  it 'should create the directory /etc/tilestache' do
    expect(chef_run).to create_directory('/etc/tilestache')
  end

  it 'should create the directory /var/log/tilestache' do
    expect(chef_run).to create_directory('/var/log/tilestache')
  end

  it 'should create the directory /var/log/tilestache/pids' do
    expect(chef_run).to create_directory('/var/log/tilestache/pids')
  end

  it 'should create the template /etc/logrotate.d/tilestache' do
    expect(chef_run).to create_template('/etc/logrotate.d/tilestache').with(owner: 'root', group: 'root', mode: 0644)
  end
end

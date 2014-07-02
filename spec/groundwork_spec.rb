require 'spec_helper'

describe 'tilestache::groundwork' do

  context 'requested user account is something other than root' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:apache_proxy]  = true
        node.set[:apache][:dir]               = '/etc/apache'
      end.converge(described_recipe)
    end

    it 'should create the user tilestache' do
      expect(chef_run).to create_user_account('tilestache').with(
        manage_home:  true,
        home:         '/home/tilestache',
        shell:        '/bin/false',
        ssh_keygen:   false,
        create_group: true,
        uid:          nil,
        git:          nil
      )
    end
  end

  context 'requested user account is root' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:user] = 'root'
      end.converge(described_recipe)
    end

    it 'should not create the user root' do
      expect(chef_run).to_not create_user_account('root')
    end
  end

  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

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

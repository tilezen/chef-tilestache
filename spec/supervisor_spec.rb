require 'spec_helper'

describe 'tilestache::supervisor' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should include recipe supervisor::default' do
    stub_command("/usr/bin/python -c 'import setuptools'").and_return(true)
    chef_run.should include_recipe 'supervisor::default'
  end

  it 'should enable the supervisor service tilestache' do
    stub_command("/usr/bin/python -c 'import setuptools'").and_return(true)
    chef_run.should enable_supervisor_service('tilestache').with(
      autostart:      true,
      startsecs:      3,
      stopwaitsecs:   3,
      stopsignal:     'TERM',
      user:           'tilestache',
      stdout_logfile: '/var/log/tilestache/supervisor.log',
      stderr_logfile: '/var/log/tilestache/supervisor.log',
      directory:      '/etc/tilestache',
      command:        "/usr/local/bin/gunicorn \
\"TileStache:WSGITileServer('/etc/tilestache/tilestache.conf')\" \
--log-file /var/log/tilestache/gunicorn.log \
-c /etc/tilestache/gunicorn.cfg"
    )
  end

end

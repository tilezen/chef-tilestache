require 'spec_helper'

describe 'tilestache::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:tilestache][:gunicorn_proxy]  = true
    end.converge(described_recipe)
  end

  it 'should python_pip install gunicorn' do
    expect(chef_run).to install_python_pip('gunicorn').with(
      version: '18.0'
    )
  end

  it 'should install tornado if worker class is tornado' do
    chef_run.node.set[:tilestache][:gunicorn][:worker_class] = 'tornado'
    chef_run.converge(described_recipe)
    expect(chef_run).to install_package 'python-tornado'
  end

  it 'should install gevent if worker class is gevent' do
    chef_run.node.set[:tilestache][:gunicorn][:worker_class] = 'gevent'
    chef_run.converge(described_recipe)
    expect(chef_run).to install_package 'python-gevent'
  end

  it 'should create gunicorn config' do
    expect(chef_run).to create_gunicorn_config('/etc/tilestache/gunicorn.cfg').with(
      pid:                  '/var/log/tilestache/pids/gunicorn.pid',
      backlog:              2048,
      preload_app:          false,
      worker_max_requests:  0,
      worker_keepalive:     5,
      worker_class:         'tornado'
    )
  end

end

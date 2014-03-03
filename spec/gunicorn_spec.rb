require 'spec_helper'

describe 'tilestache::gunicorn' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:tilestache][:gunicorn_proxy] = true
    end.converge(described_recipe)
  end

  it 'should python_pip install gunicorn' do
    chef_run.should install_python_pip 'gunicorn'
  end

  it 'should create gunicorn config' do
    chef_run.should create_gunicorn_config '/etc/tilestache/gunicorn.cfg'
  end

  context 'tornado worker class' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:gunicorn][:worker_class] = 'tornado'
      end.converge(described_recipe)

      it 'should install tornado' do
        chef_run.should install_package 'python-tornado'
      end
      it 'should not install gevent' do
        chef_run.should_not install_package 'python-gevent'
      end
    end
  end

  context 'gevent worker class' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:gunicorn][:worker_class] = 'gevent'
      end.converge(described_recipe)

      it 'should install gevent' do
        chef_run.should install_package 'python-gevent'
      end
      it 'should not install tornado' do
        chef_run.should_not install_package 'python-tornado'
      end
    end
  end

end


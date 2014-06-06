require 'spec_helper'

describe 'tilestache::install' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  %w(
    python-pip
    python-gdal
    python-shapely
    python-psycopg2
    python-memcache
    python-pylibmc
    python-redis
    python-modestmaps
    python-protobuf
  ).each do |pkg|
    it "should install package #{pkg}" do
      chef_run.should install_package pkg
    end
  end

  it 'should python_pip install image' do
    chef_run.should install_python_pip 'image'
  end

  # install method switch
  #
  context 'install method pip' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:install_method] = 'pip'
      end.converge(described_recipe)
    end

    it 'should python_pip tilestache' do
      chef_run.should install_python_pip 'tilestache'
    end
  end

  context 'install method git' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:install_method] = 'git'
      end.converge(described_recipe)
    end

    it 'should create a bash resource install-tilestache-source' do
      chef_run.should_not run_bash('install-tilestache-source').with(
        action: 'nothing'
      )
    end

    it 'should pull the source from github' do
      chef_run.should sync_git '/opt/tilestache_source'
    end

    it 'should notify bash to build from source' do
      git = chef_run.git '/opt/tilestache_source'
      expect(git).to notify('bash[install-tilestache-source]').to(:run).delayed
    end
  end

  it 'should include recipe tilestache:gunicorn' do
    chef_run.should include_recipe 'tilestache::gunicorn'
  end

  context 'init type is supervisor' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:init_type] = 'supervisor'
      end.converge(described_recipe)
    end

    it 'should include recipe tilestache::supervisor' do
      stub_command("/usr/bin/python -c 'import setuptools'").and_return(true)
      chef_run.should include_recipe 'tilestache::supervisor'
    end
  end

  context 'init type is runit' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:init_type] = 'runit'
      end.converge(described_recipe)
    end

    it 'should include recipe tilestache::runit' do
      chef_run.should include_recipe 'tilestache::runit'
    end
  end

  context 'init type is sysv' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:init_type] = 'sysv'
      end.converge(described_recipe)
    end

    it 'should include recipe tilestache::sysv' do
      chef_run.should include_recipe 'tilestache::service'
    end
  end

  context 'include sample config' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set[:tilestache][:install_method] = 'git'
        node.set[:tilestache][:config][:include_sample] = true
      end.converge(described_recipe)
    end

    it 'should create template tilestache.conf' do
      chef_run.should create_template('/etc/tilestache/tilestache.conf').with(
        owner:  'tilestache',
        group:  'tilestache',
        source: 'tilestache.conf.erb'
      )
    end

    it 'should notify tilestache to restart' do
      template = chef_run.template '/etc/tilestache/tilestache.conf'
      expect(template).to notify('service[tilestache]').to(:restart).delayed
    end
  end

  it 'should include recipe tilestache::apache' do
    chef_run.should include_recipe 'tilestache::apache'
  end

end

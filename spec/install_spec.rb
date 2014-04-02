require 'spec_helper'

describe 'tilestache::install' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  %w(
    python-pip
    python-gdal
    python-shapely
    python-psycopg2
    python-memcache
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

end

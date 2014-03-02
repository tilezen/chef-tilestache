describe 'tilestache::epel' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version:  '12.04').converge(described_recipe) }

  it 'should create the epel yum repository' do
    expect(chef_run).to create_yum_repository('epel')
  end

end

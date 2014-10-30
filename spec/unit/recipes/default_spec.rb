require 'spec_helper'

describe_recipe 'taiga::default' do
  before do
    stub_command("git --version >/dev/null").and_return(0)
  end

  it { expect(chef_run).to include_recipe('chef-sugar::default') }
  it { expect(chef_run).to include_recipe('chruby::system') }
  it { expect(chef_run).to include_recipe('nodejs::default') }
  it { expect(chef_run).to include_recipe('postgresql::client') }
  it { expect(chef_run).to include_recipe('python::default') }
  it { expect(chef_run).to include_recipe('redisio::sentinel') }
  it { expect(chef_run).to include_recipe('redisio::sentinel_enable') }

  it do
    expect(chef_run).to create_group('taiga')
      .with(system: true)
  end

  it do
    expect(chef_run).to create_user('taiga')
      .with(gid: 'taiga')
      .with(system: true)
  end
end

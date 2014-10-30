require 'spec_helper'

describe_recipe 'taiga::default' do
  it { expect(chef_run).to include_recipe('chef-sugar::default') }
  it { expect(chef_run).to include_recipe('chruby::system') }
  it { expect(chef_run).to include_recipe('nodejs::default') }
  it { expect(chef_run).to include_recipe('postgresql::client') }
end

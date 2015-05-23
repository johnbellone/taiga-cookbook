require 'spec_helper'

describe_recipe 'taiga::frontend' do
  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end

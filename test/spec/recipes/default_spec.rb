require 'spec_helper'

describe_recipe 'taiga::default' do
  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end

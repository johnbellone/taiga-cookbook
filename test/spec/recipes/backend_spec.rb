require 'spec_helper'

describe_recipe 'taiga::backend' do
  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end

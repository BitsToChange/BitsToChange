require 'spec_helper'

describe Charity do
  describe 'name' do
    it { should_not accept_values_for(:name, nil) }
    it { should_not accept_values_for(:name, '') }
    it { should_not accept_values_for(:name, 'a' * 101) }

    it { should accept_values_for(:name, 'a' * 100) }
    it { should accept_values_for(:name, 'a') }
  end

  describe 'description' do
    it { should_not accept_values_for(:description, nil) }
    it { should_not accept_values_for(:description,'') }
    it { should_not accept_values_for(:description, 'a' * 5001) }

    it { should accept_values_for(:description, 'a' * 5000) }
    it { should accept_values_for(:description, 'a') }
  end
end

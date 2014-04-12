require 'rspec'

describe Campaign do
  describe 'validations' do
    describe 'name' do
      it { should_not accept_values_for(:name, nil) }
      it { should_not accept_values_for(:name, '') }
      it { should_not accept_values_for(:name, 'a' * 101) }

      it { should accept_values_for(:name, 'a') }
      it { should accept_values_for(:name, 'a' * 100) }
    end
    describe 'description' do
      it { should_not accept_values_for(:description, nil) }
      it { should_not accept_values_for(:description, '') }
      it { should_not accept_values_for(:description, 'a' * 5001) }

      it { should accept_values_for(:description, 'a') }
      it { should accept_values_for(:description, 'a' * 5000) }
    end
    describe 'goal' do
      it { should_not accept_values_for :goal, nil }
      it { should_not accept_values_for :goal, 0 }
      it { should_not accept_values_for :goal, 1000000000 } # Limit to 1 billion
      it { should_not accept_values_for :goal, 'ardath' }

      it { should accept_values_for :goal, '1' }
      it { should accept_values_for :goal, 1 }
      it { should accept_values_for :goal, 999999999 }
    end
  end
end
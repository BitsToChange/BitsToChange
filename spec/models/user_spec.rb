require 'spec_helper'

describe User do
  describe 'validations' do
    describe 'email' do
      it { should_not accept_values_for(:email, nil)}
      it { should_not accept_values_for(:email, '')}
      it { should_not accept_values_for(:email, 'something')}
      it { should_not accept_values_for(:email, 'something@something')}
      it { should_not accept_values_for(:email, '@something.com')}
      it { should_not accept_values_for(:email, 'someone.com')}
      it { should_not accept_values_for(:email, 'someone@.com')}
      it { should_not accept_values_for(:email, 'someone@something.')}

      it { should accept_values_for(:email, 'something@something.com')}
      it { should accept_values_for(:email, 'some.thing@something.com')}
      it { should accept_values_for(:email, 'something@some.thing.com')}
      it { should accept_values_for(:email, 'some.thing@some.thing.com')}
      it { should accept_values_for(:email, 'some.thing@some.thing')}

      it do
        create :user
        #User.create!(email: 'something@somewhere.com', password: 'something', password_confirmation: 'something')
        should validate_uniqueness_of(:email)
      end
    end
  end
  describe '#has_role?' do
    context 'with no roles' do
      before { subject.roles = [] }
      it 'should be false' do
        subject.has_role?('anything').should == false
      end
    end

    context 'with a role' do
      before { subject.roles = [Role.new(name: 'something')] }
      it 'should be false with another role' do
        subject.has_role?('another').should == false
      end
      it 'should be true with that role' do
        subject.has_role?('something').should == true
      end
    end
  end
end

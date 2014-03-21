require 'spec_helper'

describe User do
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

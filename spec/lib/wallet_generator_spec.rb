require 'wallet_generator'

describe WalletGenerator do
  describe '#path_to_charity' do
    it "generates a path based on the charity's id" do
      charity = double(:id => 15)
      subject.path_to_charity(charity).should == "m/0/0/15"
    end
  end
  describe '#path_to_campaign' do
    it "generates a path based on the campaign's id" do
      campaign = double(:id => 15)
      subject.path_to_campaign(campaign).should == "m/1/0/15"
    end
  end
end

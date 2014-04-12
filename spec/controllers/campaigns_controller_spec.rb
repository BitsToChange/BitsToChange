require 'spec_helper'

describe CampaignsController do
  before :each do
    session[:userid] = create(:charity_administrator)
    @charity = create(:charity)
    @wallet = create(:wallet)

    @wallet_generator = double 'WalletGenerator'
    controller.wallet_generator = @wallet_generator
    @wallet_generator.stub(:wallet_for_campaign) { @wallet }
  end
  describe 'GET #new' do
    it 'assigns the charity to @charity' do
      get :new, :charity_id => @charity
      assigns(:charity).should == @charity
    end
    it 'assigns a campaign to @campaign' do
      get :new, :charity_id => @charity
      assigns(:campaign).should be_a_kind_of Campaign
    end
    it 'renders the new template' do
      get :new, :charity_id => @charity
      response.should render_template :new
    end
  end
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'should create a new campaign' do
        expect {
          post :create, :campaign => attributes_for(:campaign), :charity_id => @charity
        }.to change(Campaign, :count).by 1
      end
      it 'should create a new campaign for the charity' do
        @charity.campaigns.size.should == 0
        post :create, :campaign => attributes_for(:campaign), :charity_id => @charity
        @charity.reload
        @charity.campaigns.size.should == 1
      end
      it 'should generate a wallet for the campaign' do
        expect(@wallet_generator).to receive(:wallet_for_campaign).with(kind_of(Campaign)) { @wallet }
        post :create, :campaign => attributes_for(:campaign), :charity_id => @charity
      end
      it 'should add the generated wallet to the campaign' do
        post :create, :campaign => attributes_for(:campaign), :charity_id => @charity
        Campaign.last.wallets.last.should == @wallet
      end
      it 'should redirect to show' do
        post :create, :campaign => attributes_for(:campaign), :charity_id => @charity
        response.should redirect_to charity_campaign_path(@charity, Campaign.last)
      end
    end
    context 'with invalid attributes' do
      it 'rerenders the new template' do
        post :create, :campaign => attributes_for(:invalid_campaign), :charity_id => @charity
        response.should render_template :new
      end
      it 'assigns the attempted @campaign' do
        post :create, :campaign => attributes_for(:invalid_campaign), :charity_id => @charity
        assigns(:campaign).should be_a_kind_of Campaign
      end
      it 'does not create a wallet' do
        expect(@wallet_generator).to_not receive(:wallet_for_campaign)
        post :create, :campaign => attributes_for(:invalid_campaign), :charity_id => @charity
      end
      it 'does not create a campaign' do
        expect {
          post :create, :campaign => attributes_for(:invalid_campaign), :charity_id => @charity
        }.to_not change(Campaign, :count)
      end
      it 'does not add a campaign to the charity' do
        post :create, :campaign => attributes_for(:invalid_campaign), :charity_id => @charity
        @charity.reload
        @charity.campaigns.size.should == 0
      end
    end
  end
end
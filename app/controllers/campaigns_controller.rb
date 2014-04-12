class CampaignsController < ApplicationController
  attr_accessor :wallet_generator
  before_filter :new_campaign, :only => [:create]

  load_and_authorize_resource :charity
  load_and_authorize_resource :campaign, :through => :charity

  def create
    if @campaign.save
      @charity.campaigns << @campaign
      @campaign.wallets << wallet_generator.wallet_for_campaign(@campaign)
      redirect_to charity_campaign_path(@charity, @campaign)
    else
      render action: :new
    end
  end

  private
    def wallet_generator
      @wallet_generator ||= WalletGenerator.new
    end

    def new_campaign
      @campaign = Campaign.new(campaign_params)
    end

    def campaign_params
      params.require(:campaign).permit(:name, :description, :start_date, :end_date, :goal)
    end

end

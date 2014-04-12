class CampaignsController < ApplicationController
  before_filter :new_campaign, :only => [:create]

  load_and_authorize_resource :charity
  load_and_authorize_resource :campaign, :through => :charity

  def create
    @charity.campaigns << @campaign
    redirect_to charity_campaign_path(@charity, @campaign)
  end

  private
    def new_campaign
      @campaign = Campaign.new(campaign_params)
    end

    def campaign_params
      params.require(:campaign).permit(:name, :description, :start_date, :end_date)
    end

end

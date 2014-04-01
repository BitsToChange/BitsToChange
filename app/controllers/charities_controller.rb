class CharitiesController < ApplicationController
  before_action :new_charity, only: [:create]

  attr_accessor :wallet_generator

  load_and_authorize_resource

  def index
    @charities = Charity.all
  end

  def show
  end

  def new
    @charity = Charity.new
  end

  def edit
  end

  def create
    @charity = Charity.new(charity_params)

    respond_to do |format|
      if @charity.save
        format.html { redirect_to @charity, notice: 'Charity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @charity }
      else
        format.html { render action: 'new' }
        format.json { render json: @charity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /charities/1
  # PATCH/PUT /charities/1.json
  def update
    respond_to do |format|
      if @charity.update(charity_params)
        format.html { redirect_to @charity, notice: 'Charity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @charity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charities/1
  # DELETE /charities/1.json
  def destroy
    @charity.destroy
    respond_to do |format|
      format.html { redirect_to charities_url }
      format.json { head :no_content }
    end
  end

  def generate_wallet
    if @charity.wallets.length == 0
      wallet = wallet_generator.wallet_for_charity @charity
      @charity.wallets << wallet
    else
      flash[:error] = 'That charity already has a wallet.'
    end
    redirect_to charity_path @charity
  end

  def wallet_generator
    @wallet_generator ||= WalletGenerator.new
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found'
  end

  private
    def new_charity
      @charity = Charity.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def charity_params
      params.require(:charity).permit(:name, :description, :website)
    end
end

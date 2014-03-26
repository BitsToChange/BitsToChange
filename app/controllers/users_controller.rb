class UsersController < ApplicationController
  def create
    password = SecureRandom.hex
    @user = User.create!(email: params[:mailing_email], password: password, password_confirmation: password)
    Analytics.identify(
        user_id: @user.id,
        traits: { email: @user.email }
    )
    redirect_to root_path, :notice => 'You have been signed up for the mailing list.'
  rescue ActiveRecord::RecordInvalid
    redirect_to root_path, :notice => 'You are already signed up for the mailing list.'
  end
end

class UsersController < ApplicationController
  def create
    password = SecureRandom.hex
    @user = User.create!(email: params[:mailing_email], password: password, password_confirmation: password)
    identify_user @user
    redirect_to root_path, :notice => 'You have been signed up for the mailing list.'
  rescue ActiveRecord::RecordInvalid
    @user = User.find_by_email params[:mailing_email]
    identify_user @user
    redirect_to root_path, :notice => 'You are already signed up for the mailing list.'
  end

  private

    def identify_user(user)
      Analytics.identify(
          user_id: user.id,
          traits: {email: user.email, created_at: user.created_at}
      )
    end
end

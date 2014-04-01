class UsersController < ApplicationController
  attr_accessor :analytics

  def create
    password = SecureRandom.hex
    @user = User.create(email: params[:mailing_email], password: password, password_confirmation: password)
    if @user.save
      flash[:notice] = 'You have been signed up for the mailing list.'
      identify_user @user
    elsif (@user = User.find_by_email params[:mailing_email])
      flash[:error] = 'You are already signed up for the mailing list.'
      identify_user @user
    else
      flash[:error] = 'Please enter a valid email.'
    end
    redirect_to root_path
  end

  def analytics
    @analytics ||= Analytics
  end

  private

    def identify_user(user)
      analytics.identify(
          user_id: user.id,
          traits: {email: user.email, created_at: user.created_at}
      )
    end
end

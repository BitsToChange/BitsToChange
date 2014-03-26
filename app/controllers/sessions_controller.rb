class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      self.current_user = user
      redirect_to root_path, :notice => 'Logged in successfully!'
    else
      redirect_to login_path, :notice => 'Invalid email and/or password.'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end

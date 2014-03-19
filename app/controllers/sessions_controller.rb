class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:userid] = user.__id__
      redirect_to root_url, :notice => 'Logged in successfully!'
    else
      redirect_to login_url, :notice => 'Invalid username and/or password.'
    end
  end
end

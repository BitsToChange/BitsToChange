class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = 'You do not have permission to do that.'
    redirect_to root_path
  end

  ### Current user management ###
  def current_user
    @current_user ||= signed_in? ? User.find(session[:userid]) : nil
  end

  def signed_in?
    !session[:userid].nil?
  end
  helper_method :signed_in?, :current_user

  def current_user=(user)
    session[:userid] = user.id
  end

  def set_current_user(user)
    self.current_user = user
  end
end

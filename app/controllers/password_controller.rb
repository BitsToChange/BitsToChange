class PasswordController < ApplicationController
  def edit
    if !signed_in?
      redirect_to login_path, :notice => 'You need to be signed in to do that.'
    end
  end

  def update
    if params[:new_password] != params[:confirm_password]
      redirect_to change_password_path, :notice => 'Incorrect password confirmation.'
    elsif !current_user.authenticate params[:old_password]
      redirect_to change_password_path, :notice => 'Incorrect old password.'
    else
      current_user.password = params[:new_password]
      current_user.password_confirmation = params[:new_password]
      current_user.save!
      redirect_to root_path, :notice => 'You have successfully updated your password!'
    end
  end
end

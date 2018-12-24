class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    session[:google_id] = @user.google_id
    if @user.team_id.nil?
      redirect_to login_new_user_path
    else
  	  redirect_to root_path
    end
  end

  def destroy
  	session[:google_id] = nil
  	redirect_to root_path
  end
end

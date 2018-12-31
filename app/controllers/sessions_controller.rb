class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    session[:email] = @user.email
    if @user.team_id.nil?
      if Team.all.where(active: true, umbrella: true).empty?
        redirect_to first_team_path
      else
        redirect_to login_new_user_path
      end
    else
      redirect_to root_path
    end
  end

  def destroy
  	session[:email] = nil
  	redirect_to root_path
  end
end

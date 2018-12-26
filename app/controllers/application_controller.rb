class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authenticate
    redirect_to :login unless user_signed_in?
    if @pending_profile
      if Team.all.empty?
      redirect_to :first_team 
      else
      redirect_to :login_new_user
      end
    end
  end

  def current_user
    @login_user ||= User.find_by(google_id: session[:google_id]) if session[:google_id]
    unless @login_user.nil?
      @current_user = User.find_by(email: @login_user.email)
      if @current_user.team_id.nil?
        @pending_profile = true
      else
        @pending_profile = false
      end
    end
    return @current_user
  end

  def user_signed_in?
    !!current_user
  end

end

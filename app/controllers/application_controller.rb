class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :set_manager_permission, :set_user_permisson

  def authenticate
    redirect_to :login unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find_by(email: session[:email]) if session[:email]
    unless @current_user.nil? || Team.all.where(active: true, umbrella: true).empty?
      if @current_user.team_id.nil?
        redirect_to login_new_user_path
      end
    end
    return @current_user
  end

  def user_signed_in?
    !!current_user
  end

  def set_manager_permission
    @has_manager_permission = false
    if Team.all.where(active: true).count == 0 || @current_user.is_manager
      @has_manager_permission = true
    end
  end

  def set_user_permission
    if User.all.where(active: true).count == 0
      @has_user_permission = true
    else
      @has_user_permission = false
      if @current_user == @user
        @has_user_permission = true
      end
    end
  end

  def check_manager_permission
    unless @has_manager_permission
      redirect_to no_permission_path
    end
  end

  def check_user_permission
    unless @has_user_permission || @has_manager_permission
      redirect_to no_permission_path
    end
  end
end

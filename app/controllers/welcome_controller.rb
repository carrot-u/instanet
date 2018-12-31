class WelcomeController < ApplicationController
  before_action :current_user, only: [:index, :no_permission, :users, :new_user, :create_new_user]
  before_action :new_current_user, only: [:login_new_user]
  before_action :authenticate, only: [:users, :new_user, :create_new_user]
  before_action :set_new_login_user, only: [:login_new_user, :update]
  before_action :set_umbrella_manager_permission, only: [:users, :new_user, :create_new_user]
  before_action :check_manager_permission, only: [:create_new_user, :new_user]

  def index
  end

  def no_permission
  end

  def google5e8c349d90dac164
  end

  def first_team
    if !Team.all.where(active: true, umbrella: true).count == 0
      redirect_to no_permission_path
    else
      @team = Team.new
    end
  end

  def login_new_user
    if @current_user.nil?
      redirect_to login_path and return
    end
    unless @current_user.team_id.nil?
      redirect_to no_permission_path and return
    end
  end

  def users
    @users = User.all.where(active: true).order(:started_at)
  end

  def new_user
    @user = User.new
  end

  def create_new_user
    @user = User.new(user_params)
    @user.active = true

    teams = []
    teams << Team.find(@current_user.team_id)
    if Team.find(@current_user.team_id).is_parent
      sub_teams = Team.where(parent_team_id: @current_user.team_id)
      sub_teams.each do |team|
        teams << team
        while !Team.where(parent_team_id: team.id).empty?
          child_teams = Team.where(parent_team_id: team.id)
          child_teams.each do |child|
            teams << child
            team = child
          end
        end
      end
      teams.each do |team|
        if team == Team.find(@user.team_id)
          @has_permission = true
        end
      end
    end

    unless @has_permission
      redirect_to no_permission_path
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user.active = true
    respond_to do |format|
      if @user.update(user_params)
        if User.where(active: true, is_manager: true).empty?
          @user.is_manager = true
          @user.save!
        end
        if @user.email != session[:email]
          @user.email = session[:email]
          @user.save!
        end
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :login_new_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_new_login_user
    @user = User.find_by(email: session[:email])
  end

  def set_umbrella_manager_permission
    @managers = User.all.where(is_manager: true)
    @managers.each do |manager|
      if @current_user == manager
        @has_manager_permission = true
      end
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :title, :tier, :team_id, :email, :slack, :bio, :is_manager, :active, :manager_id, :started_at)
  end

  def team_params
    params.require(:team).permit(:name, :description, :active, :is_parent, :parent_team_id, :manager_id)
  end

  def new_current_user
    @current_user ||= User.find_by(email: session[:email]) if session[:email]
  end
end

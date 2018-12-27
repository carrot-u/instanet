class WelcomeController < ApplicationController
  before_action :authenticate, only: [:users, :new_user, :create_new_user]
  before_action :set_new_login_user, only: [:login_new_user, :update]
  before_action :current_user, only: [:index, :users, :new_user, :create_new_user]
  before_action :set_umbrella_manager_permission, only: [:users, :new_user, :create_new_user]
  before_action :check_manager_permission, only: [:create_new_user, :new_user]

  def index
  end

  def no_permission
  end

  def first_team
    if !Team.all.where(active: true, umbrella: true).count == 0
      redirect_to no_permission_path
    else
      @team = Team.new
    end
  end

  def login_new_user
    unless @user.team_id.nil?
      @team = Team.find_by(id: @user.team_id)
      redirect_to edit_team_user_path(@team, @user)
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

    if @user.manager_id == @user.id
      @user.manager_id = nil
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
        if @user.manager_id == @user.id
          @user.manager_id = nil
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
    @has_umbrella_manager_permission = false
    umbrella_team_id = Team.all.where(active: true, umbrella: true).first.id
    @umbrella_managers = User.all.where(team_id: umbrella_team_id, is_manager: true)
    @umbrella_managers.each do |manager|
      if @current_user == manager
        @has_umbrella_manager_permission = true
      end
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :title, :tier, :team_id, :email, :slack, :bio, :is_manager, :active, :manager_id, :started_at)
  end

  def team_params
    params.require(:team).permit(:name, :description, :active, :is_parent, :parent_team_id, :manager_id)
  end

end

class WelcomeController < ApplicationController
  before_action :authenticate, only: [:users, :new_user, :create_new_user]
  before_action :set_new_login_user, only: [:login_new_user, :update]
  before_action :current_user

  def index
  end

  def users
    @users = User.all.where(active: true).order(:started_at)
  end

  def new_user
    @user = User.new
  end

  def login_new_user
  end

  def create_new_user
    @user = User.new(user_params)
    @user.active = true

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
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :login_new_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :title, :tier, :team_id, :email, :slack, :bio, :is_manager, :active, :manager_id, :started_at)
  end

  def set_new_login_user
    @user = User.find_by(google_id: session[:google_id])
  end

end

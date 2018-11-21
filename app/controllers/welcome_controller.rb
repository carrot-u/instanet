class WelcomeController < ApplicationController
  def index
  end

  def users
    @users = User.all.where(active: true)
  end

  def new_user
    @user = User.new
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :title, :tier, :team_id, :email, :slack, :bio, :is_manager, :active, :manager_id, :started_at)
  end

end

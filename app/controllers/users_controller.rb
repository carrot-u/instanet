class UsersController < ApplicationController
  before_action :authenticate
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_user_deactivate, only: [:deactivate]
  before_action :set_team, only: [:new, :create, :index]
  before_action :set_user_extras, only: [:show]

  # GET /users
  # GET /users.json

  def index
    @users = User.all.where(active: true).where(team_id: params[:team_id]).where(is_manager: false)
    @managers = User.all.where(active: true).where(team_id: params[:team_id]).where(is_manager: true)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.active = true
    @user.team_id = @team.id

    respond_to do |format|
      if @user.save
        format.html { redirect_to team_user_path(@team, @user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to team_user_path(@team, @user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def deactivate
    respond_to do |format|
      if @user.update(active: false)
        format.html { redirect_to team_users_path(@team), notice: 'User was successfully deactivated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      @team = Team.find(@user.team_id)
    end

    def set_user_deactivate
      @user = User.find(params[:user_id])
    end

    def set_team
      @team = Team.find(params[:team_id])
    end

    def set_user_extras
      @user_badges = UserBadge.where(user_id: @user.id).where(active: true).order(updated_at: :desc)
      @user_skills = UserSkill.where(user_id: @user.id).where(active: true).order(updated_at: :desc)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :title, :tier, :team_id, :email, :slack, :bio, :is_manager, :active, :manager_id, :started_at)
    end
end

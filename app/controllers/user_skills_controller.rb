class UserSkillsController < ApplicationController
  before_action :authenticate, :set_team_user, :set_manager_permission, :set_user_permission
  before_action :set_user_skill, only: [:edit, :update]
  before_action :set_user_skill_deactivate, only: [:deactivate]
  before_action :check_user_permission, only: [:create, :update, :deactivate]

  # GET /user_skills
  # GET /user_skills.json
  def index
    @user_skills = UserSkill.where(user_id: @user.id).where(active: true)
  end

  # GET /user_skills/new
  def new
    @user_skill = UserSkill.new
  end

  # GET /user_skills/1/edit
  def edit
  end

  # POST /user_skills
  # POST /user_skills.json
  def create
    @user_skill = UserSkill.new(user_skill_params)
    @user_skill.active = true
    @user_skill.user_id = @user.id

    respond_to do |format|
      if @user_skill.save
        format.html { redirect_to team_user_path(@team, @user), notice: 'User skill was successfully created.' }
        format.json { render :show, status: :created, location: @user_skill }
      else
        format.html { render :new }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_skills/1
  # PATCH/PUT /user_skills/1.json
  def update
    respond_to do |format|
      if @user_skill.update(user_skill_params)
        format.html { redirect_to team_user_path(@team, @user), notice: 'User skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_skill }
      else
        format.html { render :edit }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_skills/1
  # DELETE /user_skills/1.json
  def deactivate
    respond_to do |format|
      if @user_skill.update(active: false)
        format.html { redirect_to team_user_path(@team, @user), notice: 'User skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_skill }
      else
        format.html { render :edit }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_skill
      @user_skill = UserSkill.find(params[:id])
    end

    def set_user_skill_deactivate
      @user_skill = UserSkill.find(params[:user_skill_id])
    end

    def set_team_user
      @user = User.find(params[:user_id])
      @team = Team.find(@user.team_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_skill_params
      params.require(:user_skill).permit(:user_id, :name, :level)
    end
end

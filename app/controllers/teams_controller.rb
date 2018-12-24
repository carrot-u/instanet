class TeamsController < ApplicationController
  before_action :authenticate
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_team_deactivate, only: [:deactivate]
  before_action :set_subteams, only: [:show]

  # GET /users
  # GET /users.json

  def index
    unless Team.all.empty?
      @team = Team.find(1)
      redirect_to team_path(@team) and return
    end
  end

  def show
    while @subteams.empty?
      redirect_to team_users_path(@team) and return
    end
  end

  # GET /users/new
  def new
    @team = Team.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @team = Team.new(team_params)
    @team.active = true

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_users_path(@team), notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_users_path(@team), notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def deactivate
    respond_to do |format|
      if @team.update(active: false)
        format.html { redirect_to teams_path, notice: 'Team was successfully deactivated' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
      @managers = User.all.where(active: true).where(team_id: @team.id).where(is_manager: true)
    end

    def set_team_deactivate
      @team = Team.find(params[:team_id])
    end

    def set_subteams
      @subteams = Team.all.where(active: true).where(parent_team_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :description, :active, :is_parent, :parent_team_id, :manager_id)
    end
end

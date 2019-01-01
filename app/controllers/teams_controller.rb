class TeamsController < ApplicationController
  before_action :authenticate
  before_action :set_team, only: [:show, :edit, :update]
  before_action :set_team_deactivate, only: [:deactivate]
  before_action :set_subteams, only: [:show]
  before_action :set_parent_team, only: [:new]
  before_action :set_manager_permission, only: [:show, :new, :edit, :update, :deactivate]
  before_action :check_manager_permission, only: [:new, :edit, :update, :deactivate]

  # GET /users
  # GET /users.json

  def index
    if Team.all.where(active: true).empty?
      redirect_to first_team_path
    else
      @team = Team.all.where(active: true).find_by(umbrella: true)
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
    unless @current_user.is_manager || Team.where(active: true, umbrella: true).count == 0
      redirect_to no_permission_path
    end

    if Team.where(active: true).count == 0
      @team = Team.new(team_params)
      @team.active = true
      @team.umbrella = true
      @team.is_parent = true
    else
      @team = Team.new(team_params)
      @team.active = true
      @team.umbrella = false
      @team.is_parent = false
    end

    if @team.parent_team_id == @team.id
      @team.parent_team_id = nil
    end

    if Team.where(active: true, umbrella: true).count == 0
      @has_permission = true
    else
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
      end
      teams.each do |team|
        if team == Team.find(@team.parent_team_id)
          @has_permission = true
        end
      end
    end

    unless @has_permission
      redirect_to no_permission_path
    end

    respond_to do |format|
      if @team.save

        unless @team.parent_team_id.nil?
          @parent = Team.find(@team.parent_team_id)
          @parent.is_parent = true
          @parent.save
        end

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
        if @team.parent_team_id == @team.id
          @team.parent_team_id = nil
          @team.save!
        end

        @teams = Team.where(active: true)
        @child_teams = Team.where.not(parent_team_id: nil)
        @teams.each do |team|
          @child_teams.each do |child|
            parent_team = Team.find(child.parent_team_id)
            if team == parent_team
              team.is_parent = true
              team.save!
            else
              team.is_parent = false
              team.save!
            end
          end
        end


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
      @team_managers = User.all.where(active: true).where(team_id: @team.id).where(is_manager: true)
    end

    def set_parent_team
      @team = Team.find(params[:parent_team_id])
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

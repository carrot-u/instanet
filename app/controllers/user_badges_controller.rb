class UserBadgesController < ApplicationController
  before_action :set_user_badge, only: [:deactivate]
  before_action :set_team_user, only: [:new, :create, :index, :deactivate]

  # GET /user_badges
  # GET /user_badges.json
  def index
    @user_badges = UserBadge.where(active: true).where(user_id: params[:user_id])
  end

  # GET /user_badges/new
  def new
    @user_badge = UserBadge.new
  end

  # POST /user_badges
  # POST /user_badges.json
  def create
    @user_badge = UserBadge.new(user_badge_params)
    @user_badge.active = true
    @user_badge.user_id = @user.id

    respond_to do |format|
      if @user_badge.save
        format.html { redirect_to team_user_path(@team, @user), notice: 'User badge was successfully created.' }
        format.json { render :show, status: :created, location: @user_badge }
      else
        format.html { render :new }
        format.json { render json: @user_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_badges/1
  # DELETE /user_badges/1.json
  def deactivate
    respond_to do |format|
      if @user_badge.update(active: false)
        format.html { redirect_to team_user_path(@team, @user), notice: 'User badge was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_badge }
      else
        format.html { render :edit }
        format.json { render json: @user_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_badge
      @user_badge = UserBadge.find(params[:user_badge_id])
    end

    def set_team_user
      @team = Team.find(params[:team_id])
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_badge_params
      params.require(:user_badge).permit(:user_id, :badge, :name, :src, :description, :active, :issued_by_id)
    end
end

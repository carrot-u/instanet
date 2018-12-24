class SearchesController < ApplicationController
  before_action :authenticate
  before_action :set_search, only: [:index, :show, :create, :update]

  # GET /searches
  # GET /searches.json
  def index
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search succsessful' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :index }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search succsessful' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :show }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @searches = Search.all
      if @searches.empty?
        @search = Search.new
      else
        @search = Search.first
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:search_term)
    end
end

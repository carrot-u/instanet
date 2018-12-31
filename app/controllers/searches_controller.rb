class SearchesController < ApplicationController
  before_action :authenticate
  before_action :set_searched, only: [:show]

  # GET /searches
  # GET /searches.json
  def index
    @search = Search.new
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search = Search.new
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_searched
      @searched = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:search_term)
    end
end

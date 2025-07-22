class BeersController < ApplicationController
  before_action :set_beer, only: [:edit, :update, :destroy]

  def index
    sort_by = params[:sort] || 'created_at'
    direction = params[:direction] || 'desc'

    # Validate sort and direction parameters to prevent SQL injection
    allowed_sort_columns = %w[created_at name brewery sourness design]
    allowed_directions = %w[asc desc]

    sort_by = 'created_at' unless allowed_sort_columns.include?(sort_by)
    direction = 'desc' unless allowed_directions.include?(direction)

    @beers = Beer.order(sort_by => direction)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @beers = @beers.where('LOWER(name) LIKE ? OR LOWER(brewery) LIKE ?', query, query)
    end

    @beers = @beers.page(params[:page]).per(9) # 9 items per page (3x3 grid)
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer = Beer.new(beer_params)
    if @beer.save
      redirect_to beers_path, notice: "Beer added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @beer.update(beer_params)
      redirect_to beers_path, notice: "Beer updated successfully."
    else
      flash.now[:alert] = "Failed to update the beer."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @beer.destroy

    flash.now[:notice] = "Beer deleted successfully."

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to beers_path, notice: "Beer deleted successfully." }
    end
  end

  private

  def set_beer
    @beer = Beer.find(params[:id])
  end

  def beer_params
    params.require(:beer).permit(:name, :brewery, :sourness, :design, :jenesaisquoi, :image)
  end
end
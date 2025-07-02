class BeersController < ApplicationController
  def index
    @beers = Beer.order(created_at: :desc)
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

  def destroy
  @beer = Beer.find(params[:id])
  @beer.destroy
  redirect_to beers_path, notice: "Beer deleted successfully."
  end

  private

  def beer_params
  params.require(:beer).permit(:name, :brewery, :sourness, :design, :jenesaisquoi, :image)
  end
end

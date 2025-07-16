class BeersController < ApplicationController
  before_action :set_beer, only: [:edit, :update, :destroy]

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
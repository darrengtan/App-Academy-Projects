class ToysController < ApplicationController

  def update
    @toy = Toy.find(params[:id])
    if @toy.update_attributes(toy_params)
      render 'show'
    else
      render json: @toy.errors.full_messages, status: 422
    end
  end

  private
  def toy_params
    params.require(:toy).permit(:happiness, :image_url, :name, :pokemon_id, :price)
  end
end

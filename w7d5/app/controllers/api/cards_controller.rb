class Api::CardsController < ApplicationController
  def create
    @card = Card.new(card_params)
    @card.list_id = params[:list_id]
    @card.ord = @card.list.new_card_ord
    if @card.save
      render :show
    else
      render json: {error: "invalid inputs"}, status: :unprocessable_entity
    end
  end

  def index
    @cards = List.find(params[:list_id]).cards.order(:ord)
    render :index
  end

  def show
    @card = Card.find(params[:id])
    render :show
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      render :show
    else
      render json: {error: "invalid inputs"}, status: :unprocessable_entity
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy!
    render json: @card
  end

  private
  def card_params
    params.require(:card).permit(:title, :description)
  end
end

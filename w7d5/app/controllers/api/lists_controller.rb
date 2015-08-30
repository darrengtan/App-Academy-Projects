class Api::ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    @list.board_id = params[:board_id]
    @list.ord = @list.board.new_list_ord
    if @list.save
      render json: @board
    else
      render json: {error: "invalid title"}, status: :unprocessable_entity
    end
  end

  def index
    @lists = Board.find(params[:board_id]).lists.order(:ord)
    render :index
  end

  def show
    @list = List.includes(:cards).find(params[:id])
    render json: @list
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      render json: @list
    else
      render json: {error: "invalid title"}, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy!
    render json: @list
  end

  private
  def list_params
    params.require(:list).permit(:title)
  end
end

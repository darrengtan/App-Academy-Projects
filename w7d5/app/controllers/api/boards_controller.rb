class Api::BoardsController < ApplicationController
  def index
    @boards = Board.all
    render :index
  end

  def show
    @board = Board.includes(:lists, :cards).find(params[:id])
    render :show
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      render json: @board
    else
      render json: {error: "invalid title"}, status: :unprocessable_entity
    end
  end

  def update
    @board= Board.find(params[:id])
    if @board.update(board_params)
      render json: @board
    else
      render json: {error: "invalid title"}, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy!
    render json: @board
  end

  private
  def board_params
    params.require(:board).permit(:title)
  end
end

require_relative 'board'
require 'byebug'

class Game
  def initialize
    @board = Board.new
    @turn = :r
  end

  def run
    until @board.over?
      play_turn
    end
    @board.render
    change_turn
    if @board.tie?
      puts "Tie!"
    else
      puts "Congratulations player #{@turn}!"
    end
  end

  def play_turn
    @board.render
    puts "Which column would you like to drop a disk in, player #{@turn}"
    column = gets.chomp.to_i
    @board.drop_disc(column, @turn)
    change_turn
  end

  def change_turn
    @turn == :r ? @turn = :b : @turn = :r
  end

end

Game.new.run

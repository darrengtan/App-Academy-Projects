require_relative 'board'

class Game
  def initialize(file)
      @board = Board.from_file(file)
  end

  def play
    until @board.solved?
      play_turn
    end
  end

  def play_turn
    @board.render
    loop do
      puts "Select Coordinates"
      coordinates = gets.chomp
      /(?<x>\d+)\D+(?<y>\d+)/ =~ coordinates
      @x, @y = x.to_i, y.to_i
      break if valid_coord?(@x, @y)
      puts "Please select valid coordinates"
    end
    loop do
      puts "Select Number"
      @num_input = gets.chomp.to_i
      break if @num_input.between?(1,9)
      puts "Please select a valid number"
    end
    @board[[@x, @y]] = Tile.new(@num_input, true)
    puts "*" * 10
  end

  def valid_coord?(x, y)
    (x.between?(0, 8) && y.between?(0, 8)) && !given_tile?([x, y])
  end

  def given_tile?(pos)
    @board[pos].given
  end
end

game = Game.new('sudoku1.txt').play

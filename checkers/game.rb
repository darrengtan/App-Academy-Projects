require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :white_player, :black_player, :players, :current_player
  def initialize
    @board = Board.new(self)
    @white_player = Player.new(:white, @board)
    @black_player = Player.new(:black, @board)
    @players = [@white_player, @black_player]
    @current_player = @players.first
  end

  def play
    until game_over?
      play_turn
      change_player_turn
    end

    render_final_board
    puts "#{current_player_color} wins!!"
  end

  private

  def play_turn
    board.render
    current_player.move_pieces
  end

  def change_player_turn
    @players.rotate!
    @current_player = @players.first
  end

  def render_final_board
    change_player_turn
    board.render
  end

  def game_over?
    current_player.teammates.size == 0
  end

  def current_player_color
    current_player.color
  end
end

if __FILE__ == $0
  g = Game.new
  g.play
end

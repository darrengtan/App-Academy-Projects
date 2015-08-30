require 'byebug'
require 'yaml'
require 'colorize'
# require_relative 'keypress'
require_relative 'board'
require_relative 'tile'

class Player
  def initialize
  end

  def prompt
    puts "select position to reveal (type 'save' to save)"
    gets.chomp.split(",")
  end
end

class Game
  attr_reader :board, :player

  def initialize(size)
    @player = Player.new
    @board = Board.new(size)
  end

  def play
    until board.over?
      board.render
      x, y, flag = player.prompt
      x == "save" ? save_game : play_round(x, y, flag)
    end

    display_result
  end

  def play_round(x, y, flag)
    pos  = x.to_i, y.to_i

    unless flag.nil?
      board[pos].flag
    else
      board[pos].reveal
    end

    board.render
  end

  def display_result
    board.lose? ? lose_message : win_message
  end

  def lose_message
    puts "You stepped on a mine."
  end

  def win_message
    puts "You're awesome!"
  end

  def save_game
    save = self.to_yaml
    File.open("save.yml", "w") { |f| f.puts(save) }
  end

end

if __FILE__==$PROGRAM_NAME
  puts "Would you like to load a previous game (y/n)?"
  response = gets.chomp
  if response.downcase == "y"
    g = YAML::load_file(File.join(__dir__, 'save.yml'))
  else
    puts "Choose a difficulty (small, medium, large)"
    case gets.chomp.downcase[0]
    when "s"
      g = Game.new(5)
    when "m"
      g = Game.new(10)
    when "l"
      g = Game.new(15)
    end
  end
  g.play
end

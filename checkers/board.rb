require_relative 'cursor'
require_relative 'pieces'
require_relative 'exceptions'
require 'colorize'
require 'byebug'

class Board
  attr_reader :cursor, :size, :grid, :game
  def initialize(game, size = 8, fake_board = false)
    @game = game
    @cursor = Cursor.new(self)
    @size = size
    create_empty_grid(size)
    fake_board ? return : [:black, :white].each { |color| fill_rows(color) }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def render
    system("clear")
    grid.each_with_index do |row, r|
      print "                 "
      row.each_with_index do |square, c|
        if square.nil?
          print "   ".colorize(:background => background(r, c))
        else
          print " #{square.symbol} ".colorize(:background => background(r, c))
        end
      end
      puts ""
    end
    print_instructions
  end

  def browse
    begin
      until cursor.start_flag
        render
        move_cursor
      end
      begin_pos = cursor.current_pos

      until !cursor.start_flag
        render
        move_cursor
      end
      finish_pos = cursor.current_pos
      raise NotMovedPiece if finish_pos == begin_pos
    end

      [begin_pos, finish_pos]
  end

  def current_player_color
    game.current_player.color
  end

  def in_range?(pos)
    x, y = pos
    x.between?(0, size - 1) && y.between?(0, size - 1)
  end

  def deep_dup
    fake_board = Board.new(game, size, true)
    pieces.each { |piece| fake_board[piece.current_pos] = piece.dup }
    fake_board
  end

  def pieces
    @grid.flatten.compact
  end

  private

  def create_empty_grid(size)
    @grid = Array.new(8) { Array.new(8) { nil } }
  end

  def fill_rows(color)
    rows = color == :white ? (size - 3..size - 1).to_a : (0..2).to_a
    @grid.each_with_index do |row, row_i|
      next if !rows.include?(row_i)
      row.map!.with_index do |square, col_i|
        square = Piece.new(self, color, [row_i, col_i]) if (row_i + col_i).even?
      end
    end
  end

  def background(row, col)
    if cursor.cursor_pos?(row, col) && piece_available_move?(row, col)
      :green
    elsif cursor.cursor_pos?(row, col)
      :yellow
    elsif piece_available_move?(row, col)
      :blue
    elsif (row + col).even?
      :black
    else
      :white
    end
  end

  def print_instructions
    puts "                   It is #{current_player_color}'s turn."
    puts "   Use wasd to move the cursor and enter to select a piece"
    puts "    If you can multi-jump but don't want to jump further,"
    puts "     press 'p' or hit enter on a non-valid jump location"
    puts "                To quit the game, press 'q'"
  end

  def piece_available_move?(row, col)
    (!self[cursor.current_pos].nil? &&
    self[cursor.current_pos].available_single_moves.include?([row, col])) ||
      (!cursor.start_pos.nil? &&
      self[cursor.start_pos].available_single_moves.include?([row, col]))
  end

  def move_cursor
    cursor.move
  end
end

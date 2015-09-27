require_relative 'tiles'

class Board
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def self.from_file(file)
    board = File.readlines(file).map do |line|
      line.chomp.split("").map {|el| Tile.new(el.to_i)}
    end
    self.new(board)
  end

  def [](pos)
    x,y = pos
    @board[x][y]
  end

  def []=(pos,val)
    x,y = pos
    @board[x][y] = val
  end

  def render
    @board.each do |line|
      puts line.map{|tile| tile.to_s}.join
    end
  end

  def solved?
    row_solved? && column_solved? && square_solved?
  end

  def row_solved?
    board.all? { |line| line.map(&:value).sort == (1..9).to_a }
  end

  def column_solved?
    board.transpose.all? { |line| line.map(&:value).sort == (1..9).to_a }
  end

  def square_solved?
    squares.all? { |line| line.sort == (1..9).to_a }
  end

  def squares
    squares = []
    (0..2).each do |row_idx|
      (0..2).each do |col_idx|
        square = create_square(row_idx, col_idx)
        squares << square
      end
    end
    squares
  end

  def create_square(row_idx, col_idx)
    square = self[[row_idx * 3, (col_idx * 3)..(col_idx * 3 + 2)]].map(&:value)
    square += self[[row_idx * 3 + 1, (col_idx * 3)..(col_idx * 3 + 2)]].map(&:value)
    square += self[[row_idx * 3 + 2, (col_idx * 3)..(col_idx * 3 + 2)]].map(&:value)
  end
end

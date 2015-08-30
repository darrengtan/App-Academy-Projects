class Board
  attr_reader :board, :size

  def initialize(size)
    @size = size
    @board = Array.new(size) {Array.new(size) {nil}}    # add_bombs
    add_tiles_board
    add_bombs
  end

  def [](pos)
    # byebug
    x, y = pos
    board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    board[x][y] = value
  end

  def add_tiles_board
    board.each_with_index do |row, row_idx|
      row.each.with_index do |tile, col_idx|
        pos = row_idx, col_idx
        self[pos] = Tile.new(board, pos)
      end
    end
  end

  def add_bombs
    bombs = 0
    count = board.flatten.length / 10

    until count == bombs
      row, col = rand(size), rand(size)
      pos = row, col
      unless self[pos].has_bomb
        self[pos].has_bomb = true
        bombs += 1
      end
    end
  end

  def render
    system("clear")
    side = (0..size).to_a.join(" ")
    puts "   #{side}"
    puts "   " + "-"*side.length
    board.each_with_index do |row, row_index|
      puts "#{row_index} |" + row.map { |tile|
        tile.render_revealed
      }.join(" ") + "|"
    end
  end

  def over?
    lose? || win?
  end

  def lose?
    board.flatten.any? { |tile| tile.has_bomb && tile.is_revealed }
  end

  def win?
    !board.flatten.any? { |tile| !tile.has_bomb && !tile.is_revealed }
  end


end

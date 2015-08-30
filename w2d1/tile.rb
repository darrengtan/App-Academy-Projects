class Tile
  DELTA = [[-1,-1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]
  attr_reader :pos
  attr_accessor :board, :has_bomb, :has_flag, :is_revealed

  def initialize(board, pos)
    @board = board
    @has_flag = false
    @has_bomb = false
    @is_revealed = false
    @pos = pos
  end

  def inspect
    {:has_bomb => has_bomb, :pos => pos}.inspect
  end

  def reveal
    return if is_revealed
    @is_revealed = true
    if neighbor_bomb_count == 0
      neighbors.each do |tile|
        tile.neighbor_bomb_count == 0 ? tile.reveal : tile.single_reveal
      end
    end
  end

  def single_reveal
    @is_revealed = true
  end

  def flag
    @has_flag == true ? @has_flag = false : @has_flag = true
  end

  def render_revealed
    if has_bomb && is_revealed
      "B"
    elsif is_revealed
      neighbor_bomb_count == 0 ? " " : neighbor_bomb_count.to_s.colorize(:red)
    elsif has_flag
      "<".colorize(:green)
    else
      "."
    end
  end

  def neighbors
    neighbors = []
    DELTA.each do |delta|

      x, y = delta[0] + pos[0], delta[1] + pos[1]
      # byebug
      neighbors << board[x][y] if x.between?(0, board.length - 1) && y.between?(0,board.length - 1)
    end
    neighbors
  end

  def neighbor_bomb_count
    bomb_count = 0
    neighbors.each do |tile|
      bomb_count += 1 if tile.has_bomb
    end
    bomb_count
  end
end

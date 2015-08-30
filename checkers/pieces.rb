class Piece

  attr_reader :board, :color, :current_pos, :kinged, :jumped, :king_row

  def initialize(board, color, pos)
    @board = board
    @color = color
    @current_pos = pos
    @jumped = false
    @kinged = false
    @king_row = @color == :white ? 0 : board.size - 1
  end

  def inspect
    {
      "color" => color,
      "pos" => current_pos,
      "kinged" => kinged,
      "jumped" => jumped
    }.inspect
  end

  def has_jumped
    @jumped = true
  end

  def has_not_jumped
    @jumped = false
  end

  def jumped?
    jumped
  end

  def king?
    in_king_row? || kinged
  end

  def in_king_row?
    current_pos[0] == king_row
  end

  def king_piece
    @kinged = true
  end

  def should_be_king?(pos)
    king? || board[pos].in_king_row?
  end

  def symbol
    if color == :white
      kinged ? "\u26C3".encode('utf-8') : "\u26C2".encode('utf-8')
    else
      kinged ? "\u26C1".encode('utf-8') : "\u26C0".encode('utf-8')
    end
  end

  def dup
    Piece.new(board, color, current_pos)
  end

  def available_single_moves
    available_slides + available_jumps
  end

  def available_jumps
    current_row, current_col = current_pos
    available_jumps_arr = []
    directions.each do |delta_row, delta_col|
      new_row = current_row + delta_row
      new_col = current_col + delta_col
      jump_row = current_row + delta_row * 2
      jump_col = current_col + delta_col * 2
      if can_jump?(new_row, new_col, jump_row, jump_col)
        available_jumps_arr << [jump_row, jump_col]
      end
    end

    available_jumps_arr
  end

  def perform_jump(finish_pos)
    row, col = current_pos
    jump_row, jump_col = finish_pos
    enemy_pos = (row + jump_row) / 2, (col + jump_col) / 2
    board[enemy_pos] = nil
    has_jumped
  end

  private

  def directions
    if color == :white
      kinged ? king_directions : [[-1, 1], [-1, -1]]
    else
      kinged ? king_directions : [[1, 1], [1, -1]]
    end
  end

  def king_directions
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

  def in_range?(row, col)
    board.in_range?([row, col])
  end

  def available_slides
    current_row, current_col = current_pos
    available_slides_arr = []
    directions.each do |delta_row, delta_col|
      new_row, new_col = current_row + delta_row, current_col + delta_col
      if in_range?(new_row, new_col) && !obstacle?(new_row, new_col)
        available_slides_arr << [new_row, new_col]
      end
    end

    available_slides_arr
  end

  def can_jump?(row, col, jump_row, jump_col)
    obstacle?(row, col) &&
    color != board[[row, col]].color &&
    !obstacle?(jump_row, jump_col) &&
    in_range?(jump_row, jump_col)
  end

  def obstacle?(row, col)
    in_range?(row, col) && !board[[row, col]].nil?
  end
end

class Player
  attr_reader :color, :board

  def initialize(color, board)
    @color = color
    @board = board
  end

  def move_pieces
    begin
      begin_pos, finish_pos = board.browse
    rescue StopJumping
      retry
    rescue NotMovedPiece
      retry
    end
    return if !@board[begin_pos].available_single_moves.include?(finish_pos)
    moving_piece = @board[begin_pos]
    if moving_piece.available_jumps.include?(finish_pos)
      moving_piece.perform_jump(finish_pos)
    end

    color = moving_piece.color
    @board[finish_pos] = Piece.new(@board, color, finish_pos)
    @board[finish_pos].has_jumped if moving_piece.jumped?
    @board[finish_pos].king_piece if moving_piece.should_be_king?(finish_pos)
    @board[begin_pos] = nil
    continue_jumping(finish_pos) if can_jump_more?(finish_pos)
  end

  def continue_jumping(pos)
    begin
      begin_pos, finish_pos = board.browse
    rescue StopJumping
      @board[pos].has_not_jumped
      return
    rescue NotMovedPiece
      @board[pos].has_not_jumped
      return
    end
    return if choose_not_to_multi_jump?(pos, begin_pos, finish_pos)
    moving_piece = @board[begin_pos]
    moving_piece.perform_jump(finish_pos)
    color = moving_piece.color
    @board[finish_pos] = Piece.new(@board, color, finish_pos)
    @board[finish_pos].has_jumped
    @board[finish_pos].king_piece if moving_piece.should_be_king?(finish_pos)
    @board[begin_pos] = nil
    if can_jump_more?(finish_pos)
      continue_jumping(finish_pos)
    else
      @board[finish_pos].has_not_jumped
    end
  end

  def can_jump_more?(pos)
    @board[pos].jumped? && !@board[pos].available_jumps.empty?
  end

  def choose_not_to_multi_jump?(pos, begin_pos, finish_pos)
    pos != begin_pos || !@board[pos].available_jumps.include?(finish_pos)
  end

  def teammates
    board.pieces.select { |piece| piece.color == color }
  end
end

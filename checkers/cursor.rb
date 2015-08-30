require 'io/console'

class Cursor
  INPUTS = {
    "w" => [-1, 0],
    "a" => [0, -1],
    "s" => [1, 0],
    "d" => [0, 1],
    "q" => :q,
    "\r" => [0, 0],
    "p" => :p
  }

  attr_reader :board, :current_pos, :start_flag, :start_pos

  def initialize(board, pos = [0, 0])
    @board = board
    @current_pos = pos
    @start_flag = false
    @start_pos = nil
  end

  def move
    input = STDIN.getch
    return if !INPUTS.include?(input)
    raise Interrupt if INPUTS[input] == :q
    raise StopJumping if INPUTS[input] == :p

    x, y = current_pos
    delta = INPUTS[input]
    new_row, new_col = x + delta[0], y + delta[1]
    if delta == [0, 0]
      return if empty_square?(new_row, new_col) || selecting_opponent?
      @start_pos = start_flag ? nil : current_pos
      @start_flag = !@start_flag
    end

    @current_pos = [new_row, new_col] if board.in_range?([new_row, new_col])
  end

  def empty_square?(row, col)
    !start_flag && board[[row, col]].nil?
  end

  def selecting_opponent?
    !start_flag && board[current_pos].color != board.current_player_color
  end

  def cursor_pos?(row, col)
    current_pos?(row, col) || start_pos?(row, col)
  end

  private

  def current_pos?(row, col)
    current_pos == [row, col]
  end

  def start_pos?(row, col)
    start_flag && start_pos == [row, col]
  end
end

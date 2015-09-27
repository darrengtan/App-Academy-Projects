class Board
  def initialize
    @grid = Array.new(6) { Array.new(7,"O") }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def drop_disc(col, disc)
    @grid.each_with_index do |row,idx|
      if empty_col_spot?(row, col, idx)
        row[col] = disc
        return
      end
    end
  end

  def empty_col_spot?(row, col, idx)
    (idx == 5) || (row[col] == "O" && self[[idx + 1, col]] != "O")
  end

  def render
    @grid.each do |row|
      puts row.join
    end
  end

  def left_start_pts
    left_start = []
    (1..2).each do |row|
      left_start << [row, 0]
    end
    (0..3).each do |col|
      left_start << [0, col]
    end
    left_start
  end

  def right_start_pts
    right_start = []
    (1..2).each do |row|
      right_start << [row, 6]
    end
    (3..6).each do |col|
      right_start << [0, col]
    end
    right_start
  end

  def create_left_diags
    diagonals = []
    left_start_pts.each do |start|
      diag = []
      x, y = start
      while x < 6 && y < 7
        diag << [x, y]
        x += 1
        y += 1
      end
      diagonals << diag
    end
    diagonals
  end

  def create_right_diags
    diagonals = []
    right_start_pts.each do |start|
      diag = []
      x, y = start
      while x < 6 && y >= 0
        diag << [x, y]
        x += 1
        y -= 1
      end
      diagonals << diag
    end
    diagonals
  end

  def diag_transform
    diagonals = create_left_diags + create_right_diags
    diagonals.each do |diag|
      diag.map!{ |pos| self[pos] }
    end
    diagonals
  end

  def over?
    row_win? || col_win? || diag_win? || tie?
  end

  def row_win?
    @grid.any? do |row|
      row.join.include?("bbbb") || row.join.include?("rrrr")
    end
  end

  def col_win?
    @grid.transpose.any? do |col|
      col.join.include?("bbbb") || col.join.include?("rrrr")
    end
  end

  def diag_win?
    diag_transform.any? do |diag|
      diag.join.include?("bbbb") || diag.join.include?("rrrr")
    end
  end

  def tie?
    !@grid.flatten.include?("O")
  end
end

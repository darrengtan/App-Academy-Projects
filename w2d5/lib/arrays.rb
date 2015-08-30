class Array
  def my_uniq
    uniq_arr = []
    self.each do |num|
      uniq_arr << num unless uniq_arr.include?(num)
    end
    uniq_arr
  end

  def two_sum
    return nil if length < 2
    sum_arr = []
    self.each_index do |start|
      finish = start + 1
      while finish < length
        sum_arr << [start, finish] if self[start] + self[finish] == 0
        finish += 1
      end
    end
    sum_arr
  end
end

def median(array)
  array = array.sort
  mid = array.length / 2
  if array.length % 2 == 0
    return (array[mid]+array[mid-1]) / 2
  else
    return array[mid]
  end
end

def my_transpose(matrix)
  length = matrix.first.length
  raise "NOOOO" unless matrix.drop(1).all?{|array| array.length == length }
  transposed_array = Array.new(length) { Array.new(length) }
  matrix.each_with_index do |row, row_i|
    row.each_with_index do |el ,col_i|
      transposed_array[col_i][row_i] = el
      # cols = []
      # (0..matrix.length - 1).each { |row_i| cols << matrix[row_i][col_i] }
      # transposed_array << cols
    end
  end
  transposed_array
end

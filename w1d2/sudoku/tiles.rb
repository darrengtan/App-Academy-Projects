require 'colorize'

class Tile
  attr_reader :value, :given

  def initialize(value, passed = false)
    @passed = passed
    @value = value
    @value == 0 ? @given = false : @given = true
  end

  def to_s
    if !@passed
      return @given ? @value.to_s.colorize(:light_black) : " "
    else
      return @value
    end
  end
end

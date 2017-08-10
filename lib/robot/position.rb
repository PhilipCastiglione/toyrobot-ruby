module Robot

  class Position
    attr_reader :x, :y

    def self.clamp(lower, value, upper)
      if value < lower
        lower
      elsif value > upper
        upper
      else
        value
      end
    end

    def initialize(x, y, grid)
      @x = self.class.clamp(0, x, grid.width - 1)
      @y = self.class.clamp(0, y, grid.height - 1)
    end

    def north(grid)
      self.class.new(@x, @y + 1, grid)
    end

    def south(grid)
      self.class.new(@x, @y - 1, grid)
    end

    def east(grid)
      self.class.new(@x + 1, @y, grid)
    end

    def west(grid)
      self.class.new(@x - 1, @y, grid)
    end
  end

end

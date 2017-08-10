# frozen_string_literal: true

module Robot

  DIRECTIONS = [:north, :east, :south, :west]

  class Grid
    attr_reader :width, :height

    def initialize(width=5, height=5)
      if width.nil? or width <= 0 or height.nil? or height <= 0
        raise ArgumentError, "width and height must be numbers greater than zero"
      end

      @width = width
      @height = height
    end
  end

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
      @x = Position::clamp(0, x, grid.width - 1)
      @y = Position::clamp(0, y, grid.height - 1)
    end
  end

  class Robot
    attr_reader :position, :direction

    def initialize(grid=nil)
      @grid = grid || Grid.new
      @position = nil
      @direction = nil
    end

    def place(x, y, direction)
      raise ArgumentError, "invalid direction" unless DIRECTIONS.include? direction
      @position = Position.new(x, y, @grid)
      @direction = direction
    end

    def move
    end

    def left
    end

    def right
    end

    def report
    end
  end

  def self.hello
    "Robot says: HELLO WORLD"
  end

  def self.main
    puts "Nothing to do"
  end

end

# frozen_string_literal: true

module Robot

  DIRECTIONS = [:north, :east, :south, :west]

  class Robot
    attr_reader :x, :y, :direction

    def initialize(grid_width=5, grid_height=5)
      if grid_width <= 0 or grid_height <= 0
        raise ArgumentError, "width and height must be greater than zero"
      end

      @grid_width = grid_width
      @grid_height = grid_height

      @x = nil
      @y = nil
      @direction = nil
    end

    def place(x, y, direction)
      raise ArgumentError, "X position out of range" if x < 0 or x >= @grid_width
      raise ArgumentError, "Y position out of range" if y < 0 or y >= @grid_height
      raise ArgumentError, "invalid direction" unless DIRECTIONS.include? direction
      @x = x
      @y = y
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

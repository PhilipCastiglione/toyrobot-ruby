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

    def north(grid)
      Position.new(@x, @y + 1, grid)
    end

    def south(grid)
      Position.new(@x, @y - 1, grid)
    end

    def east(grid)
      Position.new(@x + 1, @y, grid)
    end

    def west(grid)
      Position.new(@x - 1, @y, grid)
    end
  end

  class Robot
    attr_reader :position, :direction

    def initialize(grid=nil)
      @grid = grid || Grid.new
      @position = nil
      @direction = nil
    end

    def on_table?
      !@position.nil?
    end

    def place(x, y, direction)
      raise ArgumentError, "invalid direction" unless DIRECTIONS.include? direction
      @position = Position.new(x, y, @grid)
      @direction = direction
    end

    def move
      return unless on_table?

      case @direction
      when :north then @position = @position.north(@grid)
      when :south then @position = @position.south(@grid)
      when :east then @position = @position.east(@grid)
      when :west then @position = @position.west(@grid)
      end
    end

    def left
      return unless on_table?

      case @direction
      when :north then @direction = :west
      when :west then @direction = :south
      when :south then @direction = :east
      when :east then @direction = :north
      end
    end

    def right
      return unless on_table?

      case @direction
      when :north then @direction = :east
      when :east then @direction = :south
      when :south then @direction = :west
      when :west then @direction = :north
      end
    end

    def report
      return unless on_table?

      direction = case @direction
                  when :north then "NORTH"
                  when :east then "EAST"
                  when :south then "SOUTH"
                  when :west then "WEST"
                  else ""
                  end

      "#{@position.x},#{@position.y},#{direction}"
    end
  end

  def self.main
    puts "Nothing to do"
  end

end

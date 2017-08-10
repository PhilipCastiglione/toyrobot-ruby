module Robot

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

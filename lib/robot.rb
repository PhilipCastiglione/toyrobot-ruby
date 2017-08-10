module Robot

  class Robot
    attr_reader :x, :y, :direction

    def initialize(grid_width=5, grid_height=5)
      raise "Width must be greater than zero" if grid_width <= 0
      raise "Height must be greater than zero" if grid_height <= 0

      @grid_width = grid_width
      @grid_height = grid_height

      @x = nil
      @y = nil
      @direction = nil
    end
  end

  def self.hello
    "Robot says: HELLO WORLD"
  end

  def self.main
    puts "Nothing to do"
  end

end

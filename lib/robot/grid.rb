module Robot

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

end

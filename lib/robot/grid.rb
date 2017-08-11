module Robot
  ##
  # This class represents the dimensions of a tabletop.
  #
  class Grid
    attr_reader :width, :height

    def initialize(width = 5, height = 5)
      if width.nil? || width <= 0 || height.nil? || height <= 0
        raise ArgumentError, 'width and height must be greater than zero'
      end

      @width = width
      @height = height
    end
  end
end

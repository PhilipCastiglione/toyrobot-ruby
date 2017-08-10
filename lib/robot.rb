require 'robot/grid'
require 'robot/parser'
require 'robot/position'

module Robot
  DIRECTIONS = %i[north east south west].freeze

  class Robot
    attr_reader :position, :direction
    attr_accessor :silent

    def initialize(grid = nil)
      @grid = grid || Grid.new
      @silent = false
    end

    def run(text)
      output = []
      Parser.parse(text) do |tokens|
        output << run_command(tokens)
      end
      output.compact
    end

    def on_table?
      !@position.nil?
    end

    def place(x, y, direction)
      unless DIRECTIONS.include? direction
        raise ArgumentError, 'invalid direction'
      end

      @position = Position.new(x, y, @grid)
      @direction = direction
    end

    def move
      return unless on_table?

      case @direction
      when :north then @position = @position.north(@grid)
      when :east then @position = @position.east(@grid)
      when :south then @position = @position.south(@grid)
      when :west then @position = @position.west(@grid)
      end
    end

    def left
      return unless on_table?

      case @direction
      when :north then @direction = :west
      when :east then @direction = :north
      when :south then @direction = :east
      when :west then @direction = :south
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
      return unless DIRECTIONS.include? @direction

      "#{@position.x},#{@position.y},#{@direction.to_s.upcase}"
    end

    private

    def run_command(tokens)
      case tokens.first
      when :place then place(tokens[1], tokens[2], tokens[3])
      when :move then move
      when :left then left
      when :right then right
      when :report then return run_report
      end
      nil
    end

    def run_report
      line = report
      puts(line) unless @silent
      line
    end
  end
end

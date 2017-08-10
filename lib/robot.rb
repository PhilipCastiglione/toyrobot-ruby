# frozen_string_literal: true

require 'robot/grid'
require 'robot/parser'
require 'robot/position'

module Robot

  DIRECTIONS = [:north, :east, :south, :west]

  class Robot
    attr_reader :position, :direction
    attr_accessor :silent

    def initialize(grid=nil)
      @grid = grid || Grid.new
      @position = nil
      @direction = nil
      @silent = false
    end

    def run(text)
      output = []
      parser = Parser.new(text)
      parser.run do |tokens|
        case tokens.first
        when :place then place(tokens[1], tokens[2], tokens[3])
        when :move then move
        when :left then left
        when :right then right
        when :report
          line = report
          puts(line) unless @silent
          output << line
        end
      end
      output
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

end

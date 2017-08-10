# frozen_string_literal: true
require "spec_helper"
require "robot"

RSpec.describe Robot do
  context "with PLACE command" do

    robot = Robot::Robot.new

    it "saves the position" do
      robot.place 1, 2, :north
      expect(robot.x).to eq 1
      expect(robot.y).to eq 2
      robot.place 3, 4, :south
      expect(robot.x).to eq 3
      expect(robot.y).to eq 4
    end

    it "saves the direction" do
      robot.place 1, 2, :north
      expect(robot.direction).to eq :north
      robot.place 3, 4, :south
      expect(robot.direction).to eq :south
    end

    it "must be in range" do
      expect { robot.place -1, 0, :north }.to raise_error(ArgumentError)
      expect { robot.place 0, -1, :north }.to raise_error(ArgumentError)
      expect { robot.place 5, 0, :north }.to raise_error(ArgumentError)
      expect { robot.place 0, 5, :north }.to raise_error(ArgumentError)
    end

    it "must have a valid direction" do
      expect { robot.place 0, 0, :hubwards }.to raise_error(ArgumentError)
    end

  end
end

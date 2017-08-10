# frozen_string_literal: true
require "spec_helper"
require "robot"

RSpec.describe Robot do
  context "before receiving a PLACE command" do

    robot = Robot::Robot.new

    it "has no position" do
      expect(robot.on_table?).to be false
      expect(robot.position).to be_nil
    end

  end
end

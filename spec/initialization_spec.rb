require "robot"

RSpec.describe Robot::Robot do
  context "before receiving a PLACE command" do

    robot = Robot::Robot.new

    it "has no position or direction" do
      expect(robot.on_table?).to be false
      expect(robot.position).to be_nil
      expect(robot.direction).to be_nil
    end

  end
end

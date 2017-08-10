require "robot"

RSpec.describe Robot::Robot do

  context "with example input 1" do
    it "produces the expected output" do
      robot = Robot::Robot.new
      robot.silent = true
      output = robot.run <<-EOF
        PLACE 0,0,NORTH
        MOVE
        REPORT
      EOF
      expect(output.length).to eq 1
      expect(output.first).to eq '0,1,NORTH'
    end
  end

  context "with example input 2" do
    it "produces the expected output" do
      robot = Robot::Robot.new
      robot.silent = true
      output = robot.run <<-EOF
        PLACE 0,0,NORTH
        LEFT
        REPORT
      EOF
      expect(output.length).to eq 1
      expect(output.first).to eq '0,0,WEST'
    end
  end

  context "with example input 3" do
    it "produces the expected output" do
      robot = Robot::Robot.new
      robot.silent = true
      output = robot.run <<-EOF
        PLACE 1,2,EAST
        MOVE
        MOVE
        LEFT
        MOVE
        REPORT
      EOF
      expect(output.length).to eq 1
      expect(output.first).to eq '3,3,NORTH'
    end
  end

end

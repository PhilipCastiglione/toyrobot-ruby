# frozen_string_literal: true

require "set"

require "robot"

PROGRAM = <<-EOF
  PLACE 1,2,NORTH
  PLACE 1,2,EAST filler
  MOVE filler
  LEFT filler
  RIGHT filler
  REPORT filler

  INVALID
  PLACE
  PLACE X
  PLACE X,Y
  PLACE X,Y,Z
  PLACE X,2,NORTH
  PLACE 1,Y,NORTH
  PLACE 1,2,NORTH,0
  PLACE 1,2,HELLO
EOF

RSpec.describe Robot::Parser do

  it "recognizes all valid commands and skips others" do
    prog = Robot::Parser.new(PROGRAM)
    commands = Set.new
    prog.run do |tokens|
      commands << tokens.first
    end
    expect(commands).to eq Set.new([:place, :move, :left, :right, :report])
  end

  it "returns the commands in order" do
    prog = Robot::Parser.new(PROGRAM)
    sequence = []
    prog.run do |tokens|
      sequence << tokens
    end
    expect(sequence).to eq [
      [:place, 1, 2, :north],
      [:place, 1, 2, :east],
      [:move],
      [:left],
      [:right],
      [:report],
    ]
  end

  it "returns appropriate types for command arguments" do
    prog = Robot::Parser.new(PROGRAM)
    commands = Set.new
    prog.run do |tokens|
      command = tokens.first
      if command == :place
        expect(tokens.length).to eq 4
        expect(tokens[1]).to be_an Integer
        expect(tokens[1]).to eq 1
        expect(tokens[2]).to be_an Integer
        expect(tokens[2]).to eq 2
        expect(tokens[3]).to be_a Symbol
        expect([:north, :east]).to include tokens[3]
      else
        expect(tokens.length).to eq 1
      end
    end
  end

end

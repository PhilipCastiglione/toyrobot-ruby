require 'set'

require 'robot'

RSpec.describe Robot::Parser do
  program = <<-EOF
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

  it 'recognizes all valid commands and skips others' do
    commands = Set.new
    Robot::Parser.parse(program) do |tokens|
      commands << tokens.first
    end
    expect(commands).to eq Set.new(%i[place move left right report])
  end

  it 'returns the commands in order' do
    sequence = []
    Robot::Parser.parse(program) do |tokens|
      sequence << tokens
    end
    expect(sequence).to eq [[:place, 1, 2, :north],
                            [:place, 1, 2, :east],
                            [:move],
                            [:left],
                            [:right],
                            [:report]]
  end

  it 'returns appropriate types for command arguments' do
    Robot::Parser.parse(program) do |tokens|
      command = tokens.first
      if command == :place
        expect(tokens.length).to eq 4
        expect(tokens[1]).to be_an Integer
        expect(tokens[1]).to eq 1
        expect(tokens[2]).to be_an Integer
        expect(tokens[2]).to eq 2
        expect(tokens[3]).to be_a Symbol
        expect(%i[north east]).to include tokens[3]
      else
        expect(tokens.length).to eq 1
      end
    end
  end
end

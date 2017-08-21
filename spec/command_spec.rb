require 'robot'

def random_grid
  Robot::Grid.new(rand(10) + 1, rand(10) + 1)
end

def random_direction
  Robot::DIRECTIONS.sample
end

RSpec.describe Robot::Robot do
  context 'with PLACE command' do
    it 'saves the position and direction' do
      10.times do
        robot = Robot::Robot.new(random_grid)
        x = rand(robot.grid.width)
        y = rand(robot.grid.height)
        f = random_direction

        robot.place(x, y, f)
        expect(robot.position.x).to eq x
        expect(robot.position.y).to eq y
        expect(robot.direction).to eq f
      end
    end

    it 'must have a valid direction' do
      robot = Robot::Robot.new
      expect { robot.place(0, 0, :hubwards) }.to raise_error(ArgumentError)
    end

    it 'will be placed on the edge if given an invalid position' do
      10.times do
        robot = Robot::Robot.new(random_grid)
        max_x = robot.grid.width - 1
        max_y = robot.grid.height - 1

        f = random_direction
        robot.place(-1, -1, f)
        expect(robot.on_table?).to be true
        expect(robot.position.x).to eq 0
        expect(robot.position.y).to eq 0
        expect(robot.direction).to eq f

        f = random_direction
        robot.place(-1, 99, f)
        expect(robot.on_table?).to be true
        expect(robot.position.x).to eq 0
        expect(robot.position.y).to eq max_y
        expect(robot.direction).to eq f

        f = random_direction
        robot.place(99, -1, f)
        expect(robot.on_table?).to be true
        expect(robot.position.x).to eq max_x
        expect(robot.position.y).to eq 0
        expect(robot.direction).to eq f

        f = random_direction
        robot.place(99, 99, f)
        expect(robot.on_table?).to be true
        expect(robot.position.x).to eq max_x
        expect(robot.position.y).to eq max_y
        expect(robot.direction).to eq f
      end
    end
  end

  context 'with MOVE command' do
    it 'has no effect before PLACE' do
      robot = Robot::Robot.new
      robot.move
      expect(robot.position).to be_nil
    end

    it 'moves north' do
      robot = Robot::Robot.new
      robot.place 2, 2, :north
      robot.move
      expect(robot.position.x).to eq 2
      expect(robot.position.y).to eq 3
      expect(robot.direction).to eq :north
    end

    it 'moves south' do
      robot = Robot::Robot.new
      robot.place 2, 2, :south
      robot.move
      expect(robot.position.x).to eq 2
      expect(robot.position.y).to eq 1
      expect(robot.direction).to eq :south
    end

    it 'moves east' do
      robot = Robot::Robot.new
      robot.place 2, 2, :east
      robot.move
      expect(robot.position.x).to eq 3
      expect(robot.position.y).to eq 2
      expect(robot.direction).to eq :east
    end

    it 'moves west' do
      robot = Robot::Robot.new
      robot.place 2, 2, :west
      robot.move
      expect(robot.position.x).to eq 1
      expect(robot.position.y).to eq 2
      expect(robot.direction).to eq :west
    end

    it 'does not fall off the table' do
      10.times do
        robot = Robot::Robot.new(random_grid)
        width = robot.grid.width
        height = robot.grid.height
        max_x = width - 1
        max_y = height - 1

        robot.place 0, rand(height), :west
        robot.move
        expect(robot.position.x).to eq 0

        robot.place rand(width), 0, :south
        robot.move
        expect(robot.position.y).to eq 0

        robot.place max_x, rand(height), :east
        robot.move
        expect(robot.position.x).to eq max_x

        robot.place rand(width), max_y, :north
        robot.move
        expect(robot.position.y).to eq max_y
      end
    end
  end

  context 'with LEFT command' do
    it 'has no effect before PLACE' do
      robot = Robot::Robot.new
      robot.left
      expect(robot.direction).to be_nil
    end

    it 'turns left' do
      robot = Robot::Robot.new
      robot.place 2, 2, :north
      %i[west south east north].each do |direction|
        robot.left
        expect(robot.direction).to eq direction
      end
    end
  end

  context 'with RIGHT command' do
    it 'has no effect before PLACE' do
      robot = Robot::Robot.new
      robot.right
      expect(robot.direction).to be_nil
    end

    it 'turns right' do
      robot = Robot::Robot.new
      robot.place 2, 2, :north
      %i[east south west north].each do |direction|
        robot.right
        expect(robot.direction).to eq direction
      end
    end
  end

  context 'with REPORT command' do
    it 'has no effect before PLACE' do
      robot = Robot::Robot.new
      expect(robot.report).to be_nil
    end

    it 'returns a non-empty string' do
      robot = Robot::Robot.new
      robot.place 1, 2, :north
      output = robot.report
      expect(output).to be_a String
      expect(output.empty?).to be false
    end

    it 'returns three comma-separated values' do
      robot = Robot::Robot.new
      robot.place 1, 2, :north
      output = robot.report
      expect(output).to match(/,/)
      expect(output.split(',').length).to eq 3
    end

    it 'returns an accurate position and direction' do
      robot = Robot::Robot.new(random_grid)
      10.times do
        x = rand(robot.grid.width)
        y = rand(robot.grid.height)
        f = random_direction
        robot.place(x, y, f)
        expect(robot.report).to match(/^#{x},#{y},#{f.to_s.upcase}$/)
      end
    end
  end
end

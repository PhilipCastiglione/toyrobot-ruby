require "robot"

RSpec.describe Robot::Position do

  grid = Robot::Grid.new

  it "clamps the position" do
    position = Robot::Position.new(-1, -1, grid)
    expect(position.x).to eq 0
    expect(position.y).to eq 0

    position = Robot::Position.new(99, 99, grid)
    expect(position.x).to eq(grid.width - 1)
    expect(position.y).to eq(grid.height - 1)
  end

end

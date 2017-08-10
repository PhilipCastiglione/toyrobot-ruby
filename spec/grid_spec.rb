require 'robot'

RSpec.describe Robot::Grid do
  it 'requires a width and height' do
    expect { Robot::Grid.new(nil, 5) }.to raise_error(ArgumentError)
    expect { Robot::Grid.new(5, nil) }.to raise_error(ArgumentError)
    expect { Robot::Grid.new(0, 5) }.to raise_error(ArgumentError)
    expect { Robot::Grid.new(5, 0) }.to raise_error(ArgumentError)
  end

  it 'has a default width and height of 5 units' do
    grid = Robot::Grid.new
    expect(grid.width).to eq 5
    expect(grid.height).to eq 5
  end
end

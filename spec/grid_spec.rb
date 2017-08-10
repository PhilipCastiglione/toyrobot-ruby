# frozen_string_literal: true

require "robot"

RSpec.describe Robot::Grid do

  it "requires a width and height" do
    expect { Robot::Grid.new(nil, 5) }.to raise_error(ArgumentError)
    expect { Robot::Grid.new(5, nil) }.to raise_error(ArgumentError)
    expect { Robot::Grid.new(0, 5) }.to raise_error(ArgumentError)
    expect { Robot::Grid.new(5, 0) }.to raise_error(ArgumentError)
  end

end

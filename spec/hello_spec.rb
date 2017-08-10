require "spec_helper"
require "robot"

RSpec.describe Robot, "#hello" do
  it "says hello" do
    text = Robot::hello
    expect(text.downcase).to match(/hello world/)
  end
end

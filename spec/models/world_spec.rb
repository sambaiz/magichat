require 'rails_helper'

RSpec.describe World, :type => :model do
  it "has a valid factory" do
    expect(build(:world)).to be_valid
  end

  it "is invalid without a code" do
    world = build(:world, code: nil)
    world.valid?
    expect(world.errors[:code]).to include("can't be blank")
  end

  it "has the_end which is false by default" do
    world = build(:world, code: nil)
    expect(world.the_end).to be false
  end
end

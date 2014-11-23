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
end

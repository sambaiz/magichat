require 'rails_helper'

RSpec.describe World, :type => :model do
  it "has a valid factory" do
    expect(build(:world)).to be_valid
  end

  it "sets code before create" do
    world = create(:world, code: nil)
    expect(world.code).not_to be_nil
  end

  it "is invalid without a code on update" do
    world = create(:world)
    world.update(code: nil)
    world.valid?
    expect(world.errors[:code]).to include("can't be blank")
  end

  it "has the_end which is false by default" do
    expect(build(:world).the_end).to be false
  end

  it "is invalid without the_end on update" do
    world = create(:world)
    world.update(the_end: nil)
    world.valid?
    expect(world.errors[:the_end]).to include("can't be blank")
  end
end

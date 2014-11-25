require 'rails_helper'

RSpec.describe World, :type => :model do
  it "has a valid factory" do
    expect(build(:world)).to be_valid
  end

  it "sets code before create" do
    world = create(:world, code: nil)
    expect(world.code).not_to be_nil
  end

  it "sets unique code"

  it "has unique code"

  it "is invalid without a code on update" do
    world = create(:world)
    world.update(code: nil)
    world.valid?
    expect(world.errors[:code]).to include("can't be blank")
  end

  it "has the_end which is false by default" do
    expect(build(:world).the_end?).to be_falsy
  end

  it "has many users" do
    expect(build(:world)).to have_many(:users)
  end

  it "has many posts" do
    expect(build(:world)).to have_many(:posts)
  end
end

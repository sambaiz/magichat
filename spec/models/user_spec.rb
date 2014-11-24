require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without name" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without hp" do
    user = build(:user, hp: nil)
    user.valid?
    expect(user.errors[:hp]).to include("can't be blank")
  end

  it "is invalid without mp" do
    user = build(:user, mp: nil)
    user.valid?
    expect(user.errors[:mp]).to include("can't be blank")
  end

  it "is invalid without point_x" do
    user = build(:user, point_x: nil)
    user.valid?
    expect(user.errors[:point_x]).to include("can't be blank")
  end

  it "is invalid without point_y" do
    user = build(:user, point_y: nil)
    user.valid?
    expect(user.errors[:point_y]).to include("can't be blank")
  end

  it "is invalid without point_z" do
    user = build(:user, point_z: nil)
    user.valid?
    expect(user.errors[:point_z]).to include("can't be blank")
  end

  it "belongs to world" do
    expect(build(:user).world).to be_instance_of(World)
  end
end

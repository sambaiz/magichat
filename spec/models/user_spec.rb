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

  it "has a unique name" do
    expect(build(:user)).to validate_uniqueness_of :name
  end

  it "sets hp before create" do
    user = create(:user, hp: nil)
    expect(user.hp).not_to be_nil
  end

  it "sets mp before create" do
    user = create(:user, mp: nil)
    expect(user.mp).not_to be_nil
  end

  it "sets point_x before create" do
    user = create(:user, point_x: nil)
    expect(user.point_x).not_to be_nil
  end

  it "sets point_y before create" do
    user = create(:user, point_y: nil)
    expect(user.point_y).not_to be_nil
  end

  it "sets point_z before create" do
    user = create(:user, point_z: nil)
    expect(user.point_z).not_to be_nil
  end

  it "belongs to world" do
    expect(build(:user)).to belong_to(:world)
  end

  it "has many posts" do
    expect(build(:user)).to have_many(:posts)
  end
end

require 'rails_helper'

RSpec.describe Post, :type => :model do
  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end

  it "is invalid without text" do
    post = build(:post, text: nil)
    post.valid?
    expect(post.errors[:text]).to include("can't be blank")
  end

  it "is invalid without point_x" do
    post = build(:post, point_x: nil)
    post.valid?
    expect(post.errors[:point_x]).to include("can't be blank")
  end

  it "is invalid without point_y" do
    post = build(:post, point_y: nil)
    post.valid?
    expect(post.errors[:point_y]).to include("can't be blank")
  end

  it "is invalid without point_z" do
    post = build(:post, point_z: nil)
    post.valid?
    expect(post.errors[:point_z]).to include("can't be blank")
  end

  it "belongs to User" do
    expect(build(:post).user).to be_instance_of(User)
  end

  it "belongs to World" do
    expect(build(:post).world).to be_instance_of(World)
  end
end

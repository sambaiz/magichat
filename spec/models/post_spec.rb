require 'rails_helper'

RSpec.describe Post, :type => :model do
  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end

  it "is invalid without a text" do
    post = build(:post, text: nil)
    post.valid?
    expect(post.errors[:text]).to include("can't be blank")
  end

  it "belongs to User" do
    expect(build(:post).user).to be_instance_of(User)
  end

  it "belongs to World" do
    expect(build(:post).world).to be_instance_of(World)
  end
end

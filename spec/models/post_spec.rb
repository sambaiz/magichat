require 'rails_helper'

RSpec.describe Post, :type => :model do
  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end

  describe 'varidation' do
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
  end

  describe 'analyze' do
    it "return normal message if argument is not start with :" do
      post = create(:post, text: "fire")
      expect(post.messages[0][:message]).to eq 'fire'
    end

    it "return none if argument is start with : but magic don't exist" do
      post = create(:post, text: ":aaaaaaaa")
      expect(post.messages.size).to eq 0
    end

    it "return effect messages effect if argument is start with : and magic exist" do
      post = create(:post, text: ":fire")
      expect(post.messages[0][:message]).to match('はファイアを唱えた')
    end
  end

  describe 'relation' do
    it "belongs to User" do
      expect(build(:post)).to belong_to(:user)
    end

    it "belongs to World" do
      expect(build(:post)).to belong_to(:world)
    end
  end
end

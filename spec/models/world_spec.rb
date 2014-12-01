require 'rails_helper'

RSpec.describe World, :type => :model do

  it "has a valid factory" do
    expect(build(:world)).to be_valid
  end

  describe 'validation' do
    it "has a unique code" do
      expect(build(:world)).to validate_uniqueness_of :code
    end

    it "is invalid without a code on update" do
      world = create(:world)
      world.update(code: nil)
      world.valid?
      expect(world.errors[:code]).to include("can't be blank")
    end

    it "has the_end which is false by default" do
      expect(build(:world).the_end?).to be_falsy
    end
  end

  describe 'relation' do
    it "has many users" do
      expect(build(:world)).to have_many :users
    end

    it "has many posts" do
      expect(build(:world)).to have_many :posts
    end
  end

  it "sets code before create" do
    world = create(:world, code: nil)
    expect(world.code).not_to be_nil
  end
end

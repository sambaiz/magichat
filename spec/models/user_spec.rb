require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  describe 'varidation' do
    it "is invalid without name" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "has a unique name" do
      expect(build(:user)).to validate_uniqueness_of :name
    end

    it "is invalid without a hp on update" do
      user = create(:user)
      user.update(hp: nil)
      user.valid?
      expect(user.errors[:hp]).to include("can't be blank")
    end

    it "is invalid without a mp on update" do
      user = create(:user)
      user.update(mp: nil)
      user.valid?
      expect(user.errors[:mp]).to include("can't be blank")
    end

    it "is invalid without a point_x on update" do
      user = create(:user)
      user.update(point_x: nil)
      user.valid?
      expect(user.errors[:point_x]).to include("can't be blank")
    end

    it "is invalid without a point_y on update" do
      user = create(:user)
      user.update(point_y: nil)
      user.valid?
      expect(user.errors[:point_y]).to include("can't be blank")
    end

    it "is invalid without a point_z on update" do
      user = create(:user)
      user.update(point_z: nil)
      user.valid?
      expect(user.errors[:point_z]).to include("can't be blank")
    end

    it "is invalid without a token on update" do
      user = create(:user)
      user.update(token: nil)
      user.valid?
      expect(user.errors[:token]).to include("can't be blank")
    end
  end

  describe 'relation' do
    it "belongs to world" do
      expect(build(:user)).to belong_to(:world)
    end

    it "has many posts" do
      expect(build(:user)).to have_many(:posts)
    end
  end

  describe 'method' do
    it 'update token' do
      user = create(:user)
      old_token = user.token
      user.update_token
      expect(user.token).not_to eq old_token
    end
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

  it "sets token before create" do
    user = create(:user, token: nil)
    expect(user.token).not_to be_nil
  end
end

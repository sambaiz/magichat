require 'rails_helper'

RSpec.describe UserLog, :type => :model do
  it "has a valid factory" do
    expect(build(:user_log)).to be_valid
  end

  describe 'validation' do
    it "is invalid without user" do
      user_log = build(:user_log, user: nil)
      user_log.valid?
      expect(user_log.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid without post" do
      user_log = build(:user_log, post: nil)
      user_log.valid?
      expect(user_log.errors[:post_id]).to include("can't be blank")
    end
  end

  describe 'relation' do
    it "belongs to User" do
      expect(build(:user_log)).to belong_to(:user)
    end

    it "belongs to Post" do
      expect(build(:user_log)).to belong_to(:post)
    end
  end
end

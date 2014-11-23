require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "belongs to world" do
    expect(build(:user).world).to be_instance_of(World)
  end
end

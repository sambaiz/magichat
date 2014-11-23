require 'rails_helper'

RSpec.describe World, :type => :model do
  it "has a valid factory" do
    expect(build(:world)).to be_valid
  end
end

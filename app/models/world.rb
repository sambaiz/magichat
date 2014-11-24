require 'securerandom'

class World < ActiveRecord::Base
  before_create :set_code
  validates :code, presence: true, on: :update
  has_many :users
  has_many :posts

  def new_code
    SecureRandom.hex(8)
  end

  private
    def set_code
      self.code = new_code
    end
end


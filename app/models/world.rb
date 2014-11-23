require 'securerandom'

class World < ActiveRecord::Base
  validates :code, presence: true
  has_many :users

  def self.create_code
    SecureRandom.hex(8)
  end
end

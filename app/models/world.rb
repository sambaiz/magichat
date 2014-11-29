require 'securerandom'

class World < ActiveRecord::Base
  before_create :set_code
  validates :code, presence: true, on: :update
  validates_uniqueness_of :code
  has_many :users
  has_many :posts

  def new_code
    counter = 0
    code = nil
    loop do
      code = SecureRandom.hex(8)
      world = World.where(code: code).first
      break if world.nil? || counter > 100
      counter += 1
    end
    counter > 100 ? nil : code
  end

  private
    def set_code
      self.code = new_code
    end
end


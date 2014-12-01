require 'securerandom'

class World < ActiveRecord::Base
  before_create :set_code
  validates :code, presence: true, on: :update
  validates_uniqueness_of :code
  has_many :users
  has_many :posts

  def new_code
    loop do
      code = SecureRandom.hex(8)
      world = World.where(code: code).first
      return code if world.nil?
    end
  end

  private
    def set_code
      self.code = new_code
    end
end


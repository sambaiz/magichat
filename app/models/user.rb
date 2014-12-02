class User < ActiveRecord::Base
  belongs_to :world
  has_many :posts
  before_create :set_data
  validates :name, presence: true
  validates_uniqueness_of :name
  validates :hp, presence: true, on: :update
  validates :mp, presence: true, on: :update
  validates :point_x, presence: true, on: :update
  validates :point_y, presence: true, on: :update
  validates :point_z, presence: true, on: :update
  validates :token, presence: true, on: :update

  def update_token
    self.token = SecureRandom.hex(8)
    save
  end

  private
    def set_data
      self.hp = 100
      self.mp = 100
      self.point_x = 100
      self.point_y = 100
      self.point_z = 1
      self.token = SecureRandom.hex(8)
    end
end

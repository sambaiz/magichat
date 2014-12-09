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

  def self.near(point_x, point_y, point_z)
    users = User.all
    near = []
    users.each do |user|
      near << user if (user.point_x - point_x).abs < 10 && (user.point_y - point_y).abs < 10 && user.point_z == point_z
    end
    near
  end

  def self.valid_token?(token)
    users = User.where(token: token)
    users.length == 0
  end

  def set_random_token()
    loop do
      token = SecureRandom.hex(8)
      next unless User.valid_token?(token)
      self.token = token
      break
    end
  end

  private
    def set_data
      self.hp = 100
      self.mp = 100
      self.point_x = 100
      self.point_y = 100
      self.point_z = 100
      set_random_token
    end
end

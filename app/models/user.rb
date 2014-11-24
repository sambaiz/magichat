class User < ActiveRecord::Base
  belongs_to :world
  has_many :posts
  validates :name, presence: true
  validates :hp, presence: true
  validates :mp, presence: true
  validates :point_x, presence: true
  validates :point_y, presence: true
  validates :point_z, presence: true
end

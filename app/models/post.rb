class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :world
  validates :text, presence: true
  validates :point_x, presence: true
  validates :point_y, presence: true
  validates :point_z, presence: true
end

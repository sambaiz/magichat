class World < ActiveRecord::Base
  validates :code, presence: true
  has_many :users
end

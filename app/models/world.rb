class World < ActiveRecord::Base
  validates :code, presence: true
end

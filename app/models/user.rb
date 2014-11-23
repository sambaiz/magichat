class User < ActiveRecord::Base
  belongs_to :world
  has_many :pots
end

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :world
  validates :text, presence: true
  validates :point_x, presence: true
  validates :point_y, presence: true
  validates :point_z, presence: true

  def analyze
    return [] unless self.text.start_with?(":")
    p self.text.slice(1, -1)
    Magic.new(self.text[1..-1], self.user, self.world).effects
  end
end

class Magic
  def initialize(spell, user, world)
    @effects = []
    begin
      method(spell).call(user, world)
    rescue
    end
  end

  def effects
    @effects
  end

  def fire(user, world)
    @effects << "#{user.name} casts fire"
  end
end
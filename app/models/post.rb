class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :world
  validates :text, presence: true
  validates :point_x, presence: true
  validates :point_y, presence: true
  validates :point_z, presence: true

  def messages
    if self.text.start_with?(":")
      Magic.new(self.text[1..-1], self.user, self.world).effects
    else
      [self.text]
    end
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
    @effects << "#{user.name}はファイアを唱えた。"
  end
end
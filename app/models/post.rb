class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :world
  validates :text, presence: true
  validates :point_x, presence: true
  validates :point_y, presence: true
  validates :point_z, presence: true

  def messages(exe_magic = true) #ログを辿るときにはexe_magic = Falseで呼ぶ必要がある
    if self.text.start_with?(":")
      Magic.new(self.text[1..-1], self.user, self.world, exe_magic).effects
    else
      [{:type => :plain, :message => self.text}]
    end
  end
end

class Magic
  def initialize(spell, user, world, exe_magic)
    @effects = []
    @user = user
    @world = world
    @exe_magic = exe_magic
    begin
      method(spell).call
    rescue
    end
  end

  def effects
    @effects
  end

  def fire
    @effects << {:type => :effect, :message => "#{@user.name}はファイアを唱えた。"}
    if @exe_magic
      @effects << {:type => :effect, :message => "しかし効果はなかった！"}
    end
  end

  def up
    if @exe_magic
      @user.point_y -= 1
      @user.save
      @effects << {:type => :plain, :message => "#{@user.name}は北に移動した。(#{@user.point_x}, #{@user.point_y}, #{@user.point_z})"}
    else
      @effects << {:type => :plain, :message => "#{@user.name}は北に移動した。"}
    end
  end

  def down
    if @exe_magic
      @user.point_y += 1
      @user.save
      @effects << {:type => :plain, :message => "#{@user.name}は南に移動した。(#{@user.point_x}, #{@user.point_y}, #{@user.point_z})"}
    else
      @effects << {:type => :plain, :message => "#{@user.name}は南に移動した。"}
    end
  end

  def left
    if @exe_magic
      @user.point_x -= 1
      @user.save
      @effects << {:type => :plain, :message => "#{@user.name}は西に移動した。(#{@user.point_x}, #{@user.point_y}, #{@user.point_z})"}
    else
      @effects << {:type => :plain, :message => "#{@user.name}は西に移動した。"}
    end
  end

  def right
    if @exe_magic
      @user.point_x += 1
      @user.save
      @effects << {:type => :plain, :message => "#{@user.name}は東に移動した。(#{@user.point_x}, #{@user.point_y}, #{@user.point_z})"}
    else
      @effects << {:type => :plain, :message => "#{@user.name}は東に移動した。"}
    end
  end
end
class WorldController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @world = World.create
    @user = User.new(user_params)
    @world.users << @user
    session[:user_id] = @user.id
    redirect_to chat_url(@world.code)
  end

  def show
    @world = World.where(code: params[:code]).first
    @user = User.where(id: session[:user_id]).first
    redirect_to root_url if @world.nil?
  end

  private
    def user_params
      params[:user] = {name: params[:user][:name], hp: 100, mp: 100, point_x: 100, point_y: 100, point_z: 100} # dummy
      params.require(:user).permit(:name, :hp, :mp, :point_x, :point_y, :point_z)
    end
end

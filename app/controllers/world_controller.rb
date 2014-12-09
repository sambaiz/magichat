class WorldController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @world = World.create
    (redirect_to root_url) && return unless @user = user_create_check
    session[:user_id] = {} if session[:user_id].nil?
    session[:user_id] = session[:user_id].merge({ @world.code => @user.id })
    redirect_to chat_url(@world.code)
  end

  def show
    @world = World.where(code: params[:code]).first
    @user = User.where(id: session[:user_id][@world.code]).first
    redirect_to root_url if @world.nil? || @user.nil? || @user.world != @world
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end

    def user_create_check
      user = user_create
      return user if user.errors.empty?
      flash[:alert] =  user.errors.to_a
      nil
    end

    def user_create
      user = User.new(user_params)
      @world.users << user
      user
    end
end

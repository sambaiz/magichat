class WorldController < ApplicationController
  def index
  end

  def show
    @world = World.where(code: params[:code]).first
    if @world.nil?
      redirect_to root_url
    end
  end
end

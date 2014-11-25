class WorldController < ApplicationController
  def show
    @world = World.where(code: params[:code]).first
  end
end

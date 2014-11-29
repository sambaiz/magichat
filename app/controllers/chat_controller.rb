class ChatController < WebsocketRails::BaseController
  def initialize_session
    logger.debug("initialize chat controller")
  end

  def connect_user
    logger.debug("connected user")
  end

  def new_message
    logger.debug("Call new_message : #{message}")
    broadcast_message :new_message, message
  end
end
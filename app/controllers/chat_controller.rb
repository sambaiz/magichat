class ChatController < WebsocketRails::BaseController
  def initialize_session
    logger.debug("initialize chat controller")
  end

  def connect_user
    logger.debug("connected user")
  end

  def new_message
    gid = message[:gid]
    WebsocketRails[gid].trigger(:new_message, message)
  end
end
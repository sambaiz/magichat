class ChatController < WebsocketRails::BaseController
  def initialize_session
    logger.debug("initialize chat controller")
  end

  def connect_user
    logger.debug("connected user")
  end

  def new_message
    token = message[:token]
    user = User.where(id: session[:user_id]).first
    return if user.nil? || user.token != token
    WebsocketRails[token].trigger(:new_message, message)
    user.update_token
    WebsocketRails[token].trigger(:new_token, user.token)
  end
end
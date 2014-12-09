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
    post = Post.create(user: user, world: user.world, text: message[:body],
        point_x: user.point_x, point_y: user.point_y, point_z: user.point_z)
    post.save
    search_should_send_user(post)
  end

  def search_should_send_user(post)
    users = User.near(post.point_x, post.point_y, post.point_z)
    users.each do |user|
      send_message(post, user)
    end
  end

  def send_message(post, user)
    UserLog.create(user: user, post: post)
    fire_torigger(post, user)
  end

  def fire_torigger(post, user)
    old_token = user.token
    user.update_token
    WebsocketRails[old_token].trigger(:new_message, post.text)
    WebsocketRails[old_token].trigger(:new_token, user.token)
  end
end
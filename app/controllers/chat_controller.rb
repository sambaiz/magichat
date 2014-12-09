class ChatController < WebsocketRails::BaseController
  def initialize_session
    logger.debug("initialize chat controller")
  end

  def connect_user
    logger.debug("connected user")
  end

  def new_message
    user = User.where(id: session[:user_id]).first
    return if user.nil?
    update_token(user, message[:new_token])
    post = Post.create(user: user, world: user.world, text: message[:body],
        point_x: user.point_x, point_y: user.point_y, point_z: user.point_z)
    post.save
    send_message_all(post)
  end

  def new_token
    user = User.where(id: session[:user_id]).first
    return if user.nil?
    token = message[:new_token]
    update_token(user, token)
  end

  private

    def send_message_all(post)
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
      WebsocketRails[user.token].trigger(:new_message, post.text)
    end

    def update_token(user, token)
      valid = User.valid_token?(token)
      if valid
        user.token = token
        user.save
      else
        reset_token(token)
        WebsocketRails[token].trigger(:request_new_token, token)
      end
    end

    def reset_token(token)
      users = User.where(token: token)
      for user in users
        user.set_random_token()
        user.save
      end
    end
end
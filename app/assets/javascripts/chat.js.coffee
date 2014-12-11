class @ChatClass
  constructor: (url, useWebsocket) ->
    @world_code = $('#world_code').text()
    @dispatcher = new WebSocketRails(url, useWebsocket)
    token = @generateToken()
    console.log(url)

  bindEvents: () =>
    $('#send').on 'click', @sendMessage
    $('#msgbody').on 'keypress', @pressKey
    @channel.bind 'new_message', @receiveMessage
    @channel.bind 'request_new_token', @sendToken

  unbindEvents: () =>
    $("#send").unbind()
    $("#msgbody").unbind()

  pressKey: (event) =>
    if event.which == 13
      @sendMessage(event)
      return false
    if @move_mode
      console.log event.which
      if event.which == 106 # down
        console.log('down')
        @send(':down')
      else if event.which == 104 # left
        console.log('left')
        @send(':left')
      else if event.which == 107 # up
        console.log('up')
        @send(':up')
      else if event.which == 108 # right
        console.log('right')
        @send(':right')
      else
        @move_mode = false
        $('#msgbody').attr('placeholder','')
      return false

  sendMessage: (event) =>
    msg_body = $('#msgbody').val()
    if msg_body == ':move'
      console.log 'move mode'
      @move_mode = true
      $('#msgbody').val('')
      $('#msgbody').attr('placeholder', 'move mode (hjklで操作、それ以外のキーを押したら終了)')
      return false
    msg_body = $('#msgbody').val()
    @send(msg_body)
    $('#msgbody').val('')

  send: (msg_body) =>
    token = @generateToken()
    @dispatcher.trigger 'new_message', { world_code: @world_code, new_token: token, body: msg_body }


  receiveMessage: (message) =>
    console.log message
    switch message["type"]
      when "plain"
        $('#chat').append "#{message['message']}<br/>"
      when "effect"
        $('#chat').append "<h1>#{message['message']}</h1><br/>"

  sendToken: =>
    @dispatcher.trigger 'new_token', { world_code: @world_code, new_token: @generateToken() }

  generateToken: =>
    token = Math.random().toString(36).slice(-12)
    console.log token
    @channel = @dispatcher.subscribe(token)
    @unbindEvents()
    @bindEvents()
    token

$ ->
  window.chatClass = new ChatClass($('#chat').data('uri'), true)
class @ChatClass
  constructor: (url, useWebsocket) ->
    @dispatcher = new WebSocketRails(url, useWebsocket)
    token = @generateToken()
    console.log(url)
    @bindEvents()

  bindEvents: () =>
    $('#send').on 'click', @sendMessage
    $('#msgbody').on 'keypress', @pressKey
    @channel.bind 'new_message', @receiveMessage
    @channel.bind 'request_new_token', @sendToken

  unbindEvents: () =>
    @channnel.unbind
    $("#send").unbind()
    $("#msgbody").unbind()

  pressKey: (event) =>
    if event.which == 13
      @sendMessage(event)
      false

  sendMessage: (event) =>
    token = @generateToken()
    user_name = $('#username').text()
    msg_body = $('#msgbody').val()
    @dispatcher.trigger 'new_message', { new_token: token, body: msg_body }
    $('#msgbody').val('')

  receiveMessage: (message) =>
    console.log message
    $('#chat').append "#{message}<br/>"

  sendToken: =>
    @unbindEvents()
    @dispatcher.trigger 'new_token', { new_token: @generateToken() }
    @bindEvents()

  generateToken: =>
    token = Math.random().toString(36).slice(-12)
    console.log token
    @channel = @dispatcher.subscribe(token)
    token

$ ->
  window.chatClass = new ChatClass($('#chat').data('uri'), true)
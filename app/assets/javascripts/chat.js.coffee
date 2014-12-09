class @ChatClass
  constructor: (url, useWebsocket) ->
    token = $('#token').text()
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @channel = @dispatcher.subscribe(token)
    console.log(url)
    @bindEvents()

  bindEvents: () =>
    $('#send').on 'click', @sendMessage
    $('#msgbody').on 'keypress', @pressKey
    @channel.bind 'new_message', @receiveMessage
    @channel.bind 'new_token', @receiveToken

  unbindEvents: () =>
    $("#send").unbind()
    $("#msgbody").unbind()

  pressKey: (event) =>
    if event.which == 13
      @sendMessage(event)
      false

  sendMessage: (event) =>
    token = $('#token').text()
    user_name = $('#username').text()
    msg_body = $('#msgbody').val()
    @dispatcher.trigger 'new_message', { token: token, body: msg_body }
    $('#msgbody').val('')

  receiveMessage: (message) =>
    console.log message
    $('#chat').append "#{message}<br/>"

  receiveToken: (message) =>
    console.log message
    $('#token').text(message)
    @channel = @dispatcher.subscribe(message)
    @unbindEvents()
    @bindEvents()

$ ->
  window.chatClass = new ChatClass($('#chat').data('uri'), true)
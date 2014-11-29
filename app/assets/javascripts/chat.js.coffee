class @ChatClass
  constructor: (url, useWebsocket) ->
    group_id = $('#gid').text()
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @channel = @dispatcher.subscribe(group_id)
    console.log(url)
    @bindEvents()

  bindEvents: () =>
    $('#send').on 'click', @sendMessage
    @channel.bind 'new_message', @receiveMessage

  sendMessage: (event) =>
    user_name = $('#username').text()
    msg_body = $('#msgbody').val()
    group_id = $('#gid').text()
    @dispatcher.trigger 'new_message', { name: user_name , body: msg_body, gid: group_id }
    $('#msgbody').val('')

  receiveMessage: (message) =>
    console.log message
    $('#chat').append "#{message.name}「#{message.body}」<br/>"

$ ->
  window.chatClass = new ChatClass($('#chat').data('uri'), true)
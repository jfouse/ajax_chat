
###
# utilitiy stuff
###

ajax = {
  call: (method, path, data, callback, error_handler) ->
    $.ajax path,
      type: method
      data: data
      dataType: 'json'
      timeout: 2000
      success: (data, status, response) ->
        callback(data)
      error: (xhr, statusText, errorText) ->
        if typeof error_handler == 'function'
          error_handler(xhr, statusText, errorText)

  # convenience methods
  get: (path, data, callback, error_handler) ->
    ajax.call('GET', path, data, callback, error_handler)

  post: (path, data, callback, error_handler) ->
    ajax.call('POST', path, data, callback, error_handler)

  put: (path, data, callback, error_handler) ->
    ajax.call('PUT', path, data, callback, error_handler)
}

poll = (path, data, target) ->
  ajax.get(path, data, target)
  setTimeout (-> poll(path, data, target)), 5000


###
# User stuff
###

current_user = {
  id: ''
  name: '',
}

update_me = (data) ->
  current_user['id'] = data.id
  current_user['name'] = data.name
  $("#user-name").html data.name


idx = 0
new_user = () ->
  if idx == 5
    ## if I've tried five times with random names and I still keep getting collisions,
    #  there's most likely something else wrong; time to bail
    alert "Having trouble generating a name for you.\nSo sorry!"
  else
    max = 10000
    min = 1000
    idx++
    current_user['name'] = "User" + Math.floor(Math.random() * (max - min) + min)
    ajax.post('/users', {user: {name: current_user['name']}}, update_me, new_user)
    

who_am_I = () ->
  ajax.get(
    '/users/me',
    null,
    (data, status, response) ->
      if data.id?
        update_me(data)
      else
        new_user()
  )


###
# Content display stuff
###

update_user_box = (data) ->
  $("#users-box").html ""
  for user in data
    $("#users-box").append "<li>"+user.name+"</li>"

update_msg_box = (data) ->
  for msg in data
    $("#message-box").append "<li>"+msg.text+"</li>"



###
# Okay, fire it up
###
$(document).on "page:change", ->
  if window.location.pathname == '/'
    ## figure out who I am
    who_am_I()

    ## find out who's with me
    poll('/users.json', null, update_user_box)

    ## find out what they're saying
    poll('/messages.json', null, update_msg_box)


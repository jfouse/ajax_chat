# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

idx = 0

updateUserBox = (data) ->
  $("#users-box").html idx+":"
  for user in data
    $("#users-box").append "<li>"+user.name+"</li>"
  idx++

updateMsgBox = (data) ->
  for msg in data
    $("#message-box").append "<li>"+msg.text+"</li>"

poll = (path, target) ->
  $.ajax path,
    type: "GET"
    success: (data, status, xhr) ->
      target(data)
    dataType: 'json'
    timeout: 2000
    complete: setTimeout (-> poll(path, target)), 5000

$(document).on "page:change", ->
  if window.location.pathname == '/'
    poll('/users', updateUserBox)
    poll('/messages', updateMsgBox)

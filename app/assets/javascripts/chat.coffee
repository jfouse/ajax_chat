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

poll = (target) ->
  $.ajax '/users',
    type: "GET"
    success: (data, status, xhr) ->
      target(data)
    dataType: 'json'
    timeout: 2000
    complete: setTimeout (-> poll(target)), 5000

$(document).on "page:change", ->
  if window.location.pathname == '/'
    poll(updateUserBox)

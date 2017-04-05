# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


save= (post)->
  if post.id
    $.ajax
      url: "/posts/#{post.id}.json"
      method: 'put'
      data:
        post: post
  else
    $.ajax
      url: "/posts.json"
      method: 'post'
      data:
        post: post
serializeForm = ->
  # form.serialize() only reads key,values from top level nodes
  post = {}
  post.id = $('#id').val()
  post.title = $('#title').val()
  post.body = $('#body').val()
  post
clickEdit = ($event) ->
  $event.preventDefault()
  if $($event.target).html() == 'Edit'
    val = null
    button = 'Save'
  else
    val = true
    button = 'Edit'
    post = serializeForm()
    save(post)
  $('input,textarea').attr('disabled',val)
  $($event.target).html(button)
newComment = ($event)->
  $event.preventDefault()
  $('dd#new').removeClass('hidden')
saveComment = ($event)->
  return unless $event.keyCode == 13
  id = $('#id').val()
  $.ajax
    url: "/posts/#{id}/comments.json"
    method: 'post'
    dataType: 'html'
    data:
      comment: {body: $($event.target).val()}
  .done (response) -> $(response).insertBefore('dd#new')
  $($event.target).val('')
  $('dd#new').addClass('hidden')

# Add listeners
$(document).ready ->
  $('#edit').on 'click', clickEdit
  $('#newComment').on 'click', newComment
  $('dd#new > input').on 'keydown', saveComment

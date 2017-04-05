# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


class Post
  serialize: ->
    post={}
    post[key] = $("##{key}").val() for key in ['id','title','body']
    post
  save: ->
    if @serialize().id then @_update(@serialize()) else @_create(@serialize())
  _update: (post)->
    $.ajax
      url: "/posts/#{post.id}.json"
      method: 'put'
      data:
        post: post
  _create: (post)->
    $.ajax
      url: "/posts.json"
      method: 'post'
      data:
        post: post
    .done (response) ->
      window.location = "/posts/#{response.id}"

class EventHandlers
  constructor: (@post) ->
  clickEdit: ($event) ->
    $event.preventDefault()
    if $($event.target).html() == 'Edit'
      val = null
      button = 'Save'
    else
      val = true
      button = 'Edit'
      @post.save()
    $('input,textarea').attr('disabled',val)
    $($event.target).html(button)
  newComment: ($event)->
    $event.preventDefault()
    $('dd#new').removeClass('hidden')
    $('dd#new > input').focus()
  saveComment: ($event)->
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
  post = new Post
  handler = new EventHandlers(post)
  $('html').on 'click',   '#edit',          handler.clickEdit.bind(handler)
  $('html').on 'click',   '#newComment',    handler.newComment.bind(handler)
  $('html').on 'keydown', 'dd#new > input', handler.saveComment.bind(handler)
  $('#comments').animate({scrollTop: $('#comments').offset().top},'slow')

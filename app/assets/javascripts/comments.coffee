# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.reply-btn').click ->
    id = $(this).data('id')
    $('#form_reply_'+id).toggleClass('hide')
    $('#children_'+id).toggleClass('hide')
    $(this).find('.reply-icon').toggleClass("fa-caret-down fa-caret-up")
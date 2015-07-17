# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.tag-tokens').tokenInput '/tags.json',
    crossDomain: false
    preventDuplicates: true
    theme: 'facebook'
    prePopulate: $('.tag-tokens').data('pre')
    allowFreeTagging: true
  return
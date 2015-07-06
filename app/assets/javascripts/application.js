// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails
//= require jquery-tokeninput
//= require bootstrap-sprockets
//= require ckeditor/init
//= require_tree .

$(function () {
  $('#post_tag_tokens').tokenInput('/tags.json', { 
    crossDomain: false,
    preventDuplicates: true, 
    theme: 'facebook',
    prePopulate: $("#post_tag_tokens").data("pre"),
    allowFreeTagging: true
  });
});
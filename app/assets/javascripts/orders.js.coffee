# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $.ajax
    url: 'http://localhost:8080'
    type: 'GET'
    error: ->
      $(".fulfill").addClass 'disabled'
      $(".fulfill").removeAttr 'href'
    
    success: ->
      $(".fulfill").removeClass 'disabled'
      $(".fulfill").addAttr 'href'
      $(".fulfill").attr 'href', this.data('href')

  $.ajax
    url: 'http://localhost:8081'
    type: 'GET'
    error: ->
      $(".fulfill").addClass 'disabled'
      $(".fulfill").removeAttr 'href'
    
    success: ->
      $(".fulfill").removeClass 'disabled'
      $(".fulfill").addAttr 'href'
      $(".fulfill").attr 'href', this.data('href')
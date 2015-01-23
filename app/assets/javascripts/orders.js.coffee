# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
 
  # Toggle disabled on Fulfill Button if scale 1 responds
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

  # Toggle disabled on fulfill Button if scale 2 responds
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

  # Zero scale 1
  $("#zero-scale-1-btn").click (event) ->
    event.preventDefault
    resetScale1()

  # Zero scale 2
  $("#zero-scale-2-btn").click (event) ->
    event.preventDefault
    resetScale2()



errorResetProcess = ->
  resetScale1()
  resetScale2()



resetScale1 = ->
  $.ajax
      url: "http://127.0.0.1:8080/zero"
      success: (data) ->



resetScale2 = ->
  $.ajax
      url: "http://127.0.0.1:8081/zero"
      success: (data) ->
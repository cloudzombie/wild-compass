# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

FulfillScale =
  SCALE1_URL: 'http://localhost:8080'
  SCALE2_URL: 'http://localhost:8081'

$(document).ready ->

  # Toggle disabled on Fulfill Button if scale 1 responds
  $.get
    url: 'http://localhost:8080'
    error: ->
      $(".fulfill").addClass 'disabled'
      $(".fulfill").removeAttr 'href'
    success: ->
      $(".fulfill").removeClass 'disabled'
      $(".fulfill").addAttr('href', $(".fulfill").data('href'))

  # Toggle disabled on fulfill Button if scale 2 responds
  $.get
    url: 'http://localhost:8081'
    error: ->
      $(".fulfill").addClass 'disabled'
      $(".fulfill").removeAttr 'href'
    success: ->
      $(".fulfill").removeClass 'disabled'
      $(".fulfill").addAttr('href', $('fulfill').data('href'))

  # Zero scale 1
  $("#zero-scale-1-btn").click (event) ->
    event.preventDefault()
    resetScale1()

  # Zero scale 2
  $("#zero-scale-2-btn").click (event) ->
    event.preventDefault()
    resetScale2()

  step1()

  $('#scan-jar').submit (event) ->
    event.preventDefault()
    $.ajax
      url: '/jars/' + $('#jar').val()
      type: 'GET'
      error: ->
        errorResetProcess()
      success: ->
        step2()

  $('#scan-bag').submit (event) ->
    event.preventDefault()
    $.ajax
      url: '/bags/' + $('#bag').val()
      type: 'GET'
      error: ->
        errorResetProcess()
      success: ->
        step3()

step1 = ->
  $('#step-1').show()
  $('#step-2').hide()
  $('#step-3').hide()
  $('#step-4').hide()
  $('#step-5').hide()
  $('#scale-display').hide()

step2 = ->
  $('#step-1').hide()
  $('#step-2').show()
  $('#step-3').hide()
  $('#step-4').hide()
  $('#step-5').hide()
  $('#scale-display').hide()

step3 = ->
  $('#step-1').hide()
  $('#step-2').hide()
  $('#step-3').show()
  $('#step-4').hide()
  $('#step-5').hide()
  $('#scale-display').show()

step4 = ->
  $('#step-1').hide()
  $('#step-2').hide()
  $('#step-3').hide()
  $('#step-4').show()
  $('#step-5').hide()
  $('#scale-display').show()

step4 = ->
  $('#step-1').hide()
  $('#step-2').hide()
  $('#step-3').hide()
  $('#step-4').hide()
  $('#step-5').show()
  $('#scale-display').show()

errorResetProcess = ->
  state = 'step-1'
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
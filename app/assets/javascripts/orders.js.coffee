# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  # Toggle disabled on Fulfill Button if scale 1 responds
  $.get 'http://localhost:8080'
    .done ->
      $(".fulfill").removeClass 'disabled'
      $(".fulfill").attr('href', $(".fulfill").data('href'))
    .fail ->
      $(".fulfill").addClass 'disabled'
      $(".fulfill").removeAttr 'href'

  # Toggle disabled on fulfill Button if scale 2 responds
  $.get 'http://localhost:8081'
    .done ->
      $(".fulfill").removeClass 'disabled'
      $(".fulfill").attr('href', $('fulfill').data('href'))
    .fail ->
      $(".fulfill").addClass 'disabled'
      $(".fulfill").removeAttr 'href'    

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
    $.get '/jars/' + $('#jar').val()
      .done ->
        step2()
      .fail ->
        errorResetProcess()

  $('#scan-bag').submit (event) ->
    event.preventDefault()
    $.get '/bags/' + $('#bag').val()
      .done ->
        step3()
      .fail ->
        errorResetProcess()

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
  resetScale1()
  resetScale2()

resetScale1 = ->
  $.get 'http://localhost:8080/zero'

resetScale2 = ->
  $.get 'http://localhost:8081/zero'
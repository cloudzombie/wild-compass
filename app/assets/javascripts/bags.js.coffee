# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ReweightScale =
  SCALE1_URL: 'http://localhost:8080'
  SCALE1_METHOD: 'GET'

$(document).ready ->
 
  # Override default button behaviour
  $('.reweight').click (event) ->
    event.preventDefault
    $(location).attr('href', this.data('href'))

  # Toggle disabled on Reweight Button if scale 1 responds
  $.ajax
    url: ReweightScale.SCALE1_URL
    type: ReweightScale.SCALE1_METHOD
    error: ->
      $(".reweight").addClass 'disabled'
      $(".reweight").removeAttr 'href'
    success: ->
      $(".reweight").removeClass 'disabled'
      $(".reweight").addAttr 'href'
      $(".reweight").attr 'href', this.data('href')

  # Zero scale 1
  $("#zero-scale-1-btn").click (event) ->
    event.preventDefault
    resetScale1

  reweightStep1

  $('#scan-bag').submit (event) ->
    event.preventDefault
    $.ajax
      url: '/bags/' + $('#bag').val
      type: 'GET'
      error: ->
        errorResetReweightProcess
      success: ->
        reweightStep2

reweightStep1 = ->
  $('#reweight-bag-step-1').show
  $('#reweight-bag-step-2').hide
  $('#reweight-bag-scale-display').hide

reweightStep2 = ->
  $('#reweight-bag-step-1').hide
  $('#reweight-bag-step-2').show
  $('#reweight-bag-scale-display').show

errorResetReweightProcess = ->
  reweightStep1
  resetScale1

resetScale1 = ->
  $.ajax
      url: ReweightScale.SCALE1_URL + '/zero'
      success: (data) ->

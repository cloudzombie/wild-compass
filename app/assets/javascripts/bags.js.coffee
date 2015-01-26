# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ReweightScale =
  SCALE1_URL: 'http://localhost:8080'
  SCALE1_METHOD: 'GET'

state = undefined
bag =
  id: undefined
  current_weight: undefined
  readings: undefined
  count: undefined

# Page ready hook
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
  $("#reweight-zero-scale-1-btn").click (event) ->
    event.preventDefault()
    reweightResetScale1()

  reweightBagStep1()

  # Detect bag id
  $('#reweight-bag-scan').submit (event) ->
    event.preventDefault()
    $.ajax
      url: '/bags/' + $('#reweight-bag').val() + '.json'
      type: 'GET'
      error: ->
        reweightErrorResetProcess()
      success: (data) ->
        bag.id = data.id
        bag.current_weight = data.current_weight
        reweightBagStep2()

  # Detect weight change
  $('#reweight-bag-scale-1-readings').change (event) ->
    if bag.readings == parseInt($('#reweight-bag-scale-1-readings').text())
      bag.count += 1
      if bag.count >= 30
        reweightBagStep3()
    else
      bag.readings = parseInt($('#reweight-bag-scale-1-readings').text())

reweightBagStep1 = ->
  state = 'step-1'
  $('#reweight-bag-step-1').show()
  $('#reweight-bag-step-2').hide()
  $('#reweight-bag-step-3').hide()
  $('#reweight-bag-scale-display').hide()

reweightBagStep2 = ->
  state = 'step-2'
  $('#reweight-bag-step-1').hide()
  $('#reweight-bag-step-2').show()
  $('#reweight-bag-step-3').hide()
  $('#reweight-bag-scale-display').show()

reweightBagStep3 = ->
  state = 'step-3'
  $('#reweight-bag-step-1').hide()
  $('#reweight-bag-step-2').hide()
  $('#reweight-bag-step-3').show()
  $('#reweight-bag-scale-display').hide()  

reweightErrorResetProcess = ->
  reweightBagStep1
  reweightResetScale1

reweightResetScale1 = ->
  $.ajax
      url: ReweightScale.SCALE1_URL + '/zero'
      success: (data) ->

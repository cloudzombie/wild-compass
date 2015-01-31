# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Page ready hook
$(document).ready ->

  # Toggle disabled on Reweight Button if scale 1 responds
  $.get(
    url: 'http://localhost:8080'
    error: ->
      $('.reweight').addClass('disabled')
      $('.reweight').removeAttr('href')
    success: ->
      $('.reweight').removeClass('disabled')
      $('.reweight').addAttr('href', $('.reweight').data('href'))
    ).done (data) ->
      console.log("TOGGLE REWEIGHT BUTTON : ", data)

  # Zero scale 1
  $("#reweight-zero-scale-1-btn").click (event) ->
    event.preventDefault()
    reweightResetScale1()

  reweightBagStep1()

  # Detect bag id
  $('#reweight-bag-scan').submit (event) ->
    event.preventDefault()
    scanBag()

  # Detect weight change
  $('#reweight-bag-scale-1-readings').change (event) ->
    readings = undefined
    count = 0
    if readings == parseInt($('#reweight-bag-scale-1-readings').text())
      count += 1
      if count >= 30
        reweightBagStep3()
    else
      bag.readings = parseInt($('#reweight-bag-scale-1-readings').text())

scale1AutoRefresh = undefined

reweightBagStep1 = ->
  state = 'step-1'
  $('#reweight-bag-step-1').show()
  $('#reweight-bag-step-2').hide()
  $('#reweight-bag-step-3').hide()
  $('#reweight-bag-scale-display').hide()
  clearInterval(scale1AutoRefresh)

reweightBagStep2 = ->
  state = 'step-2'
  $('#reweight-bag-step-1').hide()
  $('#reweight-bag-step-2').show()
  $('#reweight-bag-step-3').hide()
  $('#reweight-bag-scale-display').show()
  scale1AutoRefresh = setInterval(readScale1(), 100)

reweightBagStep3 = ->
  state = 'step-3'
  $('#reweight-bag-step-1').hide()
  $('#reweight-bag-step-2').hide()
  $('#reweight-bag-step-3').show()
  $('#reweight-bag-scale-display').hide()
  clearInterval(scale1AutoRefresh)

reweightErrorResetProcess = ->
  reweightBagStep1()
  reweightResetScale1()

reweightResetScale1 = ->
  $.get 'localhost:8080/zero', (data) ->
    console.log("RESET SCALE 1 : ", data)

scanBag = ->
  $.post(
    $('#reweight-bag').data('href') + '.json',
    bag:
      scanned_hash: $('#reweight-bag').val()
  ).done( (data) ->
    if data.bag.match
      reweightBagStep2()
    else
      reweightErrorResetProcess()
  )

readScale1 = ->
  $.get('http://localhost:8080/data').done (data) ->
      $('#reweight-bag-scale-1-readings').val(data)
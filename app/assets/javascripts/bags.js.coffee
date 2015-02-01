# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Page ready hook
$(document).ready ->

  # Toggle disabled on Reweight Button if scale 1 responds
  $.get 'http://localhost:8080'
    .fail ->
      $('.reweight').prop('disabled', true)
      $('.reweight').removeAttr('href')
    .done ->
      $('.reweight').prop('disabled', false)
      $('.reweight').attr('href', $('.reweight').data('href'))

  # Detect bag id
  $('#reweight-bag-scan').submit (event) ->
    event.preventDefault()
    scanBag()

  # Detect weight change
  $('#reweight-bag-scale-1-readings').change (event) ->
    weight = parseFloat($('#reweight-bag-scale-1-readings').val().trim())
    reweightBagStep3()
    $('#reweight-bag-scale-1-readings').val(weight)

  reweightBagStep1()

scale1AutoRefresh = null

# Step 1 of reweight process
reweightBagStep1 = ->
  $('#reweight-bag-step-1').show()
  $('#reweight-bag-step-2').hide()
  $('#reweight-bag-step-3').hide()
  $('#reweight-bag-scale-display').hide()
  clearInterval(scale1AutoRefresh)

# Step 2 of reweight process
reweightBagStep2 = ->
  $('#reweight-bag-step-1').hide()
  $('#reweight-bag-step-2').show()
  $('#reweight-bag-step-3').hide()
  $('#reweight-bag-scale-display').show()
  scale1AutoRefresh = setInterval readScale1, 100

# Step 3 of reweight process
reweightBagStep3 = ->
  $('#reweight-bag-step-1').hide()
  $('#reweight-bag-step-2').hide()
  $('#reweight-bag-step-3').show()
  # $('#reweight-bag-scale-display').hide()
  clearInterval(scale1AutoRefresh)

# Reset Reweight Process
reweightErrorResetProcess = ->
  reweightBagStep1()
  reweightResetScale1()

# Reset scale 1
reweightResetScale1 = ->
  $.get 'http://localhost:8080/zero'

# Scan bag's datamatrix
scanBag = ->
  $.post(
    $('#reweight-bag').data('href') + '.json',
    bag:
      scanned_hash: $('#reweight-bag').val()
  ).done (data) ->
    if data.bag.match
      reweightBagStep2()
    else
      reweightErrorResetProcess()

# Read data from scale 1
readScale1 = ->
  $.get 'http://localhost:8080/data'
    .done (data) ->
      $('#reweight-bag-scale-1-readings').val(data)
      $('#reweight-bag-scale-1-readings').change()
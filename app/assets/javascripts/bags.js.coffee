# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class BagsController
  init: ->
    console.log 'bags#init'
    $(document).ready ->
      # Toggle disabled on Reweight Button if scale 1 responds
      $.get 'http://localhost:8080'
        .fail ->
          $('.reweight').prop('disabled', true)
          $('.reweight').removeAttr('href')
        .done ->
          $('.reweight').prop('disabled', false)
          # $('.reweight').attr('href', this.data('href'))

  index: ->
    console.log 'bags#index'

  show: ->
    console.log 'bags#show'

  new: ->
    console.log 'bags#new'

  edit: ->
    console.log 'bags#edit'

  reweight: ->
    console.log 'bags#reweight'
    $(document).ready ->
      # Detect bag id
      $('#reweight-bag-scan').submit (event) ->
        event.preventDefault()
        scanBag()

      $('#reweight-bag-weight').submit (event) ->
        message = $('#reweight-bag-message')
        tareWeight = $('#reweight-bag-tare-weight')
        if message && message.val() && tareWeight && tareWeight.val()
          return
        else
          event.preventDefault()

      # Detect weight change
      $('#reweight-bag-scale-1-readings').change (event) ->
        weight = parseFloat($('#reweight-bag-scale-1-readings').val().trim())
        reweightBagStep3()
        $('#reweight-bag-scale-1-readings').val(weight)

      reweightBagStep1()

this.WildCompass.bags = new BagsController

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
  $('#reweight-bag-tare-weight').focus()
  clearInterval(scale1AutoRefresh)

# Reset Reweight Process
reweightErrorResetProcess = ->
  reweightBagStep1()

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
  $.get('http://localhost:8080/data').done (data) ->
    $('#reweight-bag-scale-1-readings').val(data)
    $('#reweight-bag-scale-1-readings').change()
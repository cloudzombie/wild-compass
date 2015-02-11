# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class SeedsController
  init: ->
    console.log 'seeds#init'
    jQuery ->
      $('#seed_plant_ids').select2({ })

  index: ->
    console.log 'seeds#index'
    $(document).ready ->
      # Toggle disabled on reweight button if scale responds
      $.get 'http://localhost:8080'
        .fail ->
          $('.reweight').prop('disabled', true)
          $('.reweight').removeAttr('href')
        .done ->
          $('.reweight').prop('disabled', false)
          # $('.reweight').attr('href', this.data('href'))

  show: ->
    console.log 'seeds#show'

  new: ->
    console.log 'seeds#new'

  edit: ->
    console.log 'seeds#edit'

  reweight: ->
    console.log 'seeds#reweight'
    $(document).ready ->

      # Detect seed id
      $('#reweight-seed-scan').submit (event) ->
        event.preventDefault()
        scanSeed()

      $('#reweight-seed-weight').submit (event) ->
        message = $('#reweight-seed-message')
        if message && message.val()
          return
        else
          event.preventDefault()

      # Detect weight change
      $('#reweight-seed-scale-1-readings').change (event) ->
        weight = parseFloat($('#reweight-seed-scale-1-readings').val().trim())
        reweightSeedStep3()
        $('#reweight-seed-scale-1-readings').val(weight)

      reweightSeedStep1()

this.WildCompass.seeds = new SeedsController

scale1AutoRefresh = null

# Step 1 of reweight process
reweightSeedStep1 = ->
  $('#reweight-seed-step-1').show()
  $('#reweight-seed-step-2').hide()
  $('#reweight-seed-step-3').hide()
  $('#reweight-seed-scale-display').hide()
  clearInterval(scale1AutoRefresh)

# Step 2 of reweight process
reweightSeedStep2 = ->
  $('#reweight-seed-step-1').hide()
  $('#reweight-seed-step-2').show()
  $('#reweight-seed-step-3').hide()
  $('#reweight-seed-scale-display').show()
  scale1AutoRefresh = setInterval readScale1, 100

# Step 3 of reweight process
reweightSeedStep3 = ->
  $('#reweight-seed-step-1').hide()
  $('#reweight-seed-step-2').hide()
  $('#reweight-seed-step-3').show()
  clearInterval(scale1AutoRefresh)

# Reset Reweight Process
reweightErrorResetProcess = ->
  reweightSeedStep1()

# Scan seed's datamatrix
scanSeed = ->
  $.post(
    $('#reweight-seed').data('href') + '.json',
    seed:
      scanned_hash: $('#reweight-seed').val()
  ).done (data) ->
    if data.seed.match
      reweightSeedStep2()
    else
      reweightErrorResetProcess()

# Read data from scale 1
readScale1 = ->
  $.get('http://localhost:8080/data').done (data) ->
    $('#reweight-seed-scale-1-readings').val(data)
    $('#reweight-seed-scale-1-readings').change()
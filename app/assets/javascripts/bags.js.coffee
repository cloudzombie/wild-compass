# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# default scale url
SCALE1_URL = "http://localhost:8080"

# default reweight scale selector
REWEIGHT_SELECTOR = "#reweight-bag-scale-1-readings"

this.WildCompass.Reweight = class Reweight
  constructor: ->
    # Instantiate a scale
    @scale = new WildCompass.Scale(SCALE1_URL, REWEIGHT_SELECTOR)

  # Step 1 of reweight process
  step1: ->
    $('#reweight-bag-step-1').show()
    $('#reweight-bag-step-2').hide()
    $('#reweight-bag-step-3').hide()
    $('#reweight-bag-scale-display').hide()
    @scale.stop()
    return

  # Step 2 of reweight process
  step2: ->
    $('#reweight-bag-step-1').hide()
    $('#reweight-bag-step-2').show()
    $('#reweight-bag-step-3').hide()
    $('#reweight-bag-scale-display').show()
    @scale.start()
    return

  # Step 3 of reweight process
  step3: ->
    $('#reweight-bag-step-1').hide()
    $('#reweight-bag-step-2').hide()
    $('#reweight-bag-step-3').show()
    $('#reweight-bag-tare-weight').focus()
    @scale.stop()
    return

  # Reset Reweight Process
  reset: ->
    this.step1()
    return

this.WildCompass.Bag = class Bag
  constructor: ->
    @reweight = new Reweight

  startReweight: ->
    @reweight.step1()
    return

  # Scan bag's datamatrix
  scan: ->
    $.post(
      $('#reweight-bag').data('href') + '.json',
      bag:
        scanned_hash: $('#reweight-bag').val()
    ).done (data) =>
      if data.bag.match
        @reweight.step2()
      else
        @reweight.reset()
    return

class BagsController
  init: ->
    console.log 'bags#init'

  index: ->
    console.log 'bags#index'
    # Toggle disabled on Reweight Button if scale 1 responds
    $.get 'http://localhost:8080'
      .fail ->
        $('.reweight').prop('disabled', true)
        $('.reweight').removeAttr('href')
      .done ->
        $('.reweight').prop('disabled', false)

  show: ->
    console.log 'bags#show'

  new: ->
    console.log 'bags#new'

  edit: ->
    console.log 'bags#edit'

  reweight: ->
    console.log 'bags#reweight'
    
    console.log "Creating bag instance..."
    @bag = new Bag

    console.log "Starting reweight process..."
    @bag.startReweight()
  
    console.log "Attaching scan callbacks..."
    # Detect bag id
    $('#reweight-bag-scan').submit (event) =>
      event.preventDefault()
      @bag.scan()

    console.log "Attaching reweight callbacks..."
    $('#reweight-bag-weight').submit (event) ->
      message = $('#reweight-bag-message')
      tareWeight = $('#reweight-bag-tare-weight')
      if message && message.val() && tareWeight && tareWeight.val()
        return
      else
        event.preventDefault()

    console.log "Attaching scale callbacks..."
    # Detect weight change
    $('#reweight-bag-scale-1-readings').change (event) =>
      weight = parseFloat($('#reweight-bag-scale-1-readings').val().trim())
      @bag.reweight.step3()
      $('#reweight-bag-scale-1-readings').val(weight)

this.WildCompass.bags = new BagsController

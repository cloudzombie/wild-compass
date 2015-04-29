# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Instantiate an order from rails model
this.WildCompass.Order = class Order
  @find: (id, fn) ->
    $.getJSON "/orders/" + id + ".json", (data) -> fn(data)

SCALE_RESOLUTION = 0.101

bagId = null
bagWeight = null

jarId = null
jarWeight = null
jarQuantity = null

transactionWeight = null

hasNext = null
nextUrl = null

bagScaleReadings = []
jarScaleReadings = []

bagScalePreviousReadings = null
jarScalePreviousReadings = null

bagScaleCurrentReadings = null
jarScaleCurrentReadings = null

class OrdersController
  init: ->
    console.log 'orders#init'

  index: ->
    console.log 'orders#index'

  show: ->
    console.log 'orders#show'

  new: ->
    console.log 'orders#new'

  edit: ->
    console.log 'orders#edit'

  fulfill: ->
    console.log 'orders#fulfill'

    bagId = $('#fulfill-order-bag').data('id')
    jarId = $('#fulfill-order-jar').data('id')
    jarQuantity = parseFloat($('#fulfill-order-jar').data('quantity'))

    hasNext = Boolean($('#fulfill-order-next').data('next'))
    nextUrl = $('#fulfill-order-next').data('next-url')

    # Toggle disabled on Fulfill Button if scale 1 responds
    $.get 'http://localhost:8080'
      .done ->
        $(".fulfill").prop('disabled', false)
        # $(".fulfill").attr('href', this.data('href'))
      .fail ->
        $(".fulfill").prop('disabled', true)
        $(".fulfill").removeAttr('href')

    # Toggle disabled on fulfill Button if scale 2 responds
    $.get 'http://localhost:8081'
      .done ->
        $(".fulfill").prop('disabled', false)
        # $(".fulfill").attr('href', this.data('href'))
      .fail ->
        $(".fulfill").prop('disabled', true)
        $(".fulfill").removeAttr('href')

    # Zero scale 1
    $("#zero-scale-1-btn").click (event) ->
      event.preventDefault()
      resetScale1()

    # Zero scale 2
    $("#zero-scale-2-btn").click (event) ->
      event.preventDefault()
      resetScale2()

    $('#fulfill-order-scale-1-input').submit (event) ->
      event.preventDefault()

    $('#fulfill-order-scale-2-input').submit (event) ->
      event.preventDefault()

    $('#fulfill-order-scan-jar-form').submit (event) ->
      event.preventDefault()
      fulfillScanJar()

    $('#fulfill-order-scan-bag-form').submit (event) ->
      event.preventDefault()
      fulfillScanBag()

    $('#fulfill-order-scale-1-input').change (event) ->
      weightChanged()

    $('#fulfill-order-scale-2-input').change (event) ->
      weightChanged()

    $('#fulfill-order-commit').click (event) ->
      event.preventDefault()
      commit()

    fulfillOrderStep1()

fulfillOrderScale1AutoRefresh = null
fulfillOrderScale2AutoRefresh = null

fulfillOrderStep1 = ->
  # Tare scales
  resetScale1()
  resetScale2()
  # Display UI
  $('#step-1').show()
  $('#step-2').hide()
  $('#step-3').hide()
  $('#step-4').hide()
  $('.scale-display').hide()
  $('#fulfill-order-scan-jar-input').focus()
  # Stop reading
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

fulfillOrderStep2 = ->
  # Display UI
  $('#step-1').hide()
  $('#step-2').show()
  $('#step-3').hide()
  $('#step-4').hide()
  $('.scale-display').hide()
  $('#fulfill-order-scan-bag-input').focus()
  # Stop reading
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

fulfillOrderStep3 = ->
  # Display UI
  $('#step-1').hide()
  $('#step-2').hide()
  $('#step-3').show()
  $('#step-4').hide()
  $('.scale-display').show()
  # Tare scales
  resetScale1()
  resetScale2()
  # Start reading
  fulfillOrderScale1AutoRefresh = setInterval fulfillOrderReadScale1, 100
  fulfillOrderScale2AutoRefresh = setInterval fulfillOrderReadScale2, 100

fulfillOrderStep4 = ->
  # Display UI
  $('#step-1').hide()
  $('#step-2').hide()
  $('#step-3').hide()
  $('#step-4').show()
  $('.scale-display').show()
  # Stop reading
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

errorResetProcess = ->
  fulfillOrderStep1()

resetScale1 = ->
  $.get('http://localhost:8080/zero')

resetScale2 = ->
  $.get('http://localhost:8081/zero')

# Scan a bag's datamatrix
fulfillScanBag = ->
  $.post(
    $('#fulfill-order-scan-bag-input').data('href') + '.json',
    bag:
      scanned_hash: $('#fulfill-order-scan-bag-input').val()
  ).done (data) ->
    if data.bag.match
      fulfillOrderStep3()
    else
      errorResetProcess()

# Scan a jar's datamatrix
fulfillScanJar = ->
  $.post(
    $('#fulfill-order-scan-jar-input').data('href') + '.json',
    jar:
      scanned_hash: $('#fulfill-order-scan-jar-input').val()
    ).done (data) ->
      if data.jar.match
        fulfillOrderStep2()
      else
        errorResetProcess()

# Read data from scale 1
fulfillOrderReadScale1 = ->
  $.get('http://localhost:8080/data').done (data) ->
    $('#fulfill-order-scale-1-input').val(data)
    $('#fulfill-order-scale-1-input').change()

# Read data from scale 2
fulfillOrderReadScale2 = ->
  $.get('http://localhost:8081/data').done (data) ->
    $('#fulfill-order-scale-2-input').val(data)
    $('#fulfill-order-scale-2-input').change()

# Detect a weight change on scales
weightChanged = ->

  # bagWeight = parseFloat($('#fulfill-order-scale-1-input').val().trim())
  # jarWeight = parseFloat($('#fulfill-order-scale-2-input').val().trim())

  console.log "Fetching data from scale..."
  bagScaleText = $('#fulfill-order-scale-1-input').val().trim()
  jarScaleText = $('#fulfill-order-scale-2-input').val().trim()
  
  console.log "Parsing weights..."
  bagScaleCurrentReading = parseFloat(bagScaleText)
  jarScaleCurrentReading = parseFloat(jarScaleText)

  console.log "Pushing weights in buffer..."
  bagScaleReadings.push bagScaleCurrentReading
  jarScaleReadings.push jarScaleCurrentReading

  console.log "Removing oldest buffer values..."
  if bagScaleReadings.length > 30
    bagScaleReadings.shift()
  if jarScaleReadings.length > 30
    jarScaleReadings.shift()

  console.log "Displaying buffer..."
  console.log bagScaleReadings
  console.log jarScaleReadings

  console.log "Computing buffer averages..."
  bagWeightsSum = 0.0
  jarWeightsSum = 0.0
  # Sum of readings buffer
  bagWeightsSum += i for i in bagScaleReadings
  jarWeightsSum += j for j in jarScaleReadings
  # Average of readings buffer
  bagWeightsAverage = bagWeightsSum / bagScaleReadings.length
  jarWeightsAverage = jarWeightsSum / jarScaleReadings.length  

  console.log "Displaying buffer average..."
  console.log bagWeightsAverage
  console.log jarWeightsAverage

  transactionWeight = jarWeight
  
  console.log "Checking scale stability criteria..."
  if stable(bagScaleText) && stable(jarScaleText) && (bagScaleCurrentReading != null) && (bagScalePreviousReadings != null) && (jarScaleCurrentReading != null) && (jarScalePreviousReadings != null) && inBounds(bagScalePreviousReadings, bagScaleCurrentReading) && inBounds(jarScalePreviousReadings, jarScaleCurrentReading) && full(bagScaleReadings) && full(jarScaleReadings) && inBounds(bagWeightsAverage, bagScaleCurrentReading) && inBounds(jarWeightsAverage, jarScaleCurrentReading)
    fulfillOrderStep4()

  console.log "Saving previous weights for next iteration..."
  bagScalePreviousReadings = bagScaleCurrentReading
  jarScalePreviousReadings = jarScalePreviousReadings

stable = (reading) ->
  !(reading.indexOf('?') >= 0)

full = (buffer) ->
  buffer.length == 30

inBounds = (a, b) ->
  Math.abs(a - b) <= SCALE_RESOLUTION

commit = ->
  $.post(
    $('#fulfill-order').data('href'),
    order:
      bag: bagId
      jar: jarId
      weight: transactionWeight
  )
  if hasNext
    setTimeout($(location).attr('href', nextUrl), 500)
  else
    setTimeout($(location).attr('href', '/orders'), 500)

this.WildCompass.orders = new OrdersController
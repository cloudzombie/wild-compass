SCALE_RESOLUTION = 0.101

bagId = null
bagWeight = null

jarId = null
jarWeight = null
jarQuantity = null

transactionWeight = null

hasNext = null
nextUrl = null

bagScaleText = null
jarScaleText = null

bagScaleReadings = []
jarScaleReadings = []

bagScalePreviousReading = null
jarScalePreviousReading = null

bagScaleCurrentReading = null
jarScaleCurrentReading = null

bagWeightsAverage = null
jarWeightsAverage = null

this.WildCompass.OrdersController = class OrdersController
  init: ->
    console.log 'orders#init'

  index: ->
    console.log 'orders#index'

    # Toggle disabled on Fulfill Button if scale 1 responds
    $.get 'http://localhost:8080'
      #.done -> $(".fulfill").prop('disabled', false).andSelf().fadeIn()
      .fail -> $(".fulfill").prop('disabled', true).andSelf().removeAttr('href').andSelf().fadeOut()

    # Toggle disabled on fulfill Button if scale 2 responds
    $.get 'http://localhost:8081'
      #.done -> $(".fulfill").prop('disabled', false).andSelf().fadeIn()
      .fail -> $(".fulfill").prop('disabled', true).andSelf().removeAttr('href').andSelf().fadeOut()

  show: ->
    console.log 'orders#show'

  new: ->
    console.log 'orders#new'

  edit: ->
    console.log 'orders#edit'

  fulfill: ->
    console.log 'orders#fulfill'

    console.log "Fetching order by id..."
    WildCompass.Order.find $('#order').data('id'), (order) ->
      $.each order.order_lines, (i, line) ->
        $.each line.jars, (j, jar) ->
          console.log jar
          jarId = parseInt(jar.id)
          jarQuantity = parseFloat(jar.ordered_amount)
          bagId = jar.incoming_bags[0].id
          next = jar.next
          hasNext = Boolean(jar.next)
          console.log jarId, jarQuantity, bagId, hasNext

    # Prevent default actions on scales text inputs
    # It serves as read only display for weights
    $('#fulfill-order-scale-1-input').submit (event) -> event.preventDefault()
    $('#fulfill-order-scale-2-input').submit (event) -> event.preventDefault()

    # Prevent default actions on scans text inputs
    $('#fulfill-order-scan-jar-form').submit (event) -> event.preventDefault()
    $('#fulfill-order-scan-bag-form').submit (event) -> event.preventDefault()
      #fulfillScanJar()
      #fulfillScanBag()

    # Notify change handler
    $('#fulfill-order-scale-1-input').change (event) -> weightChanged()
    $('#fulfill-order-scale-2-input').change (event) -> weightChanged()

    # Intercept commit action and handle it with commit function
    $('#fulfill-order-commit').click (event) ->
      event.preventDefault()
      $('fulfill-order-commit').fadeOut()
      commit()

    # Begin fulfill
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
  
  console.log "Checking scale stability criteria..."
  if notNull() && isStable() && buffersFull() && inBounds() && weightMatches() && transactionMatches()
    transactionWeight = jarScaleCurrentReading
    fulfillOrderStep4()

  console.log "Saving previous weights for next iteration..."
  bagScalePreviousReading = bagScaleCurrentReading
  jarScalePreviousReading = jarScaleCurrentReading

stable = (reading) ->
  !(reading.indexOf('?') >= 0)

full = (buffer) ->
  buffer.length == 30

transactionMatches = -> withinBound(jarScaleCurrentReading, jarQuantity) && withinBound(bagScaleCurrentReading, jarQuantity)

withinBound = (a, b) -> Math.abs(Math.abs(a) - Math.abs(b)) <= SCALE_RESOLUTION

match = (a, b) -> Math.abs(a + b) <= SCALE_RESOLUTION

weightMatches = -> match(jarScaleCurrentReading, bagScaleCurrentReading) && match(jarWeightsAverage, bagWeightsAverage) && match(jarScalePreviousReading, bagScalePreviousReading) && match(jarScalePreviousReading, bagScaleCurrentReading) && match(jarScaleCurrentReading, bagScalePreviousReading)

notNull = -> bagReadingsNotNull() && jarReadingsNotNull()

buffersFull = -> full(bagScaleReadings) && full(jarScaleReadings)

isStable = -> stable(bagScaleText) && stable(jarScaleText) 

inBounds = -> withinBound(bagScalePreviousReading, bagScaleCurrentReading) && withinBound(jarScalePreviousReading, jarScaleCurrentReading) && withinBound(bagWeightsAverage, bagScaleCurrentReading) && withinBound(jarWeightsAverage, jarScaleCurrentReading)

bagReadingsNotNull = -> (bagScaleCurrentReading != null) && (bagScalePreviousReading != null)

jarReadingsNotNull = -> (jarScaleCurrentReading != null) && (jarScalePreviousReading != null)

commit = ->
  $.post $('#fulfill-order').data('href'), { order: { bag: bagId, jar: jarId, weight: transactionWeight }}, (data) ->
    if hasNext
      setTimeout($(location).attr('href', nextUrl), 500)
    else
      setTimeout($(location).attr('href', '/orders'), 500)

this.WildCompass.orders = new OrdersController
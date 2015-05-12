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

BAG_SCALE_URL = 'http://localhost:8080'
JAR_SCALE_URL = 'http://localhost:8081'

SCALE_RESOLUTION = 0.101

this.WildCompass.OrdersController = class OrdersController
  init: ->
    WildCompass.Logger.info "Processing Javascript by OrdersController#init"

  index: ->
    WildCompass.Logger.info "Processing Javascript by OrdersController#index"

    # Toggle fulfill button if scales respond
    setInterval( ->
      $.get BAG_SCALE_URL
        .done -> $(".fulfill").each -> $(this).prop('disabled', false).andSelf().prop('href', $(this).data('href')).andSelf().fadeIn()
        .fail -> $(".fulfill").each -> $(this).prop('disabled', true).andSelf().prop('href', '#').andSelf().fadeOut()

      # Toggle disabled on fulfill Button if scale 2 responds
      $.get JAR_SCALE_URL
        .done -> $(".fulfill").each -> $(this).prop('disabled', false).andSelf().prop('href', $(this).data('href')).andSelf().fadeIn()
        .fail -> $(".fulfill").each -> $(this).prop('disabled', true).andSelf().prop('href', '#').andSelf().fadeOut()
    , 1000)

  show: ->
    WildCompass.Logger.info "Processing Javascript by OrdersController#show"

  new: ->
    WildCompass.Logger.info "Processing Javascript by OrdersController#new"

  edit: ->
    WildCompass.Logger.info "Processing Javascript by OrdersController#edit"

  fulfill: ->
    WildCompass.Logger.info "Processing Javascript by OrdersController#fulfill"
    WildCompass.Logger.debug 'Displaying interface...'
    $('#step-1').show()
    $('#step-2').hide()
    $('#step-3').hide()
    $('#step-4').hide()
    $('.scale-display').hide()
    $('#fulfill-order-scan-jar-input').focus()

    WildCompass.Logger.debug "Fetching order by id..."
    WildCompass.Order.find $('#order').data('id'), (order) ->
      $.each order.order_lines, (i, line) ->
        $.each line.jars, (j, jar) ->
          fulfillJar parseInt(jar.id), parseFloat(jar.ordered_amount), jar.incoming_bags[0].id

    fulfillJar = (jar_id, jar_quantity, bag_id) ->
      fulfillOrderStep1()
      $('#fulfill-order-scan-jar-form').submit (event) -> fulfillScanJar(jar_id, jar_quantity, bag_id)

    # Scan a jar's datamatrix
    fulfillScanJar = (id, quantity, bag_id) ->
      $.post "/jars/" + id + "/scan.json", { jar: { scanned_hash: $('#fulfill-order-scan-jar-input').val() }}
        .done (data) ->
          if data.jar.match
            jarQuantity = quantity
            WildCompass.Logger.debug "Jar matches proceeding to step 2..."
            fulfillOrderStep2()
            $('#fulfill-order-scan-bag-form').submit (event) -> fulfillScanBag(bag_id)
    
    # Scan a bag's datamatrix
    fulfillScanBag = (id) ->
      $.post "/bags/" + id + "/scan.json", { bag: { scanned_hash: $('#fulfill-order-scan-bag-input').val() }}
        .done (data) ->
          if data.bag.match
            WildCompass.Logger.debug "Bag matches proceeding to step 3..."
            fulfillOrderStep3()

    # Prevent default actions on scales text inputs
    # It serves as read only display for weights
    $('#fulfill-order-scale-1-input').submit (event) -> event.preventDefault()
    $('#fulfill-order-scale-2-input').submit (event) -> event.preventDefault()

    # Prevent default actions on scans text inputs
    $('#fulfill-order-scan-jar-form').submit (event) -> event.preventDefault()
    $('#fulfill-order-scan-bag-form').submit (event) -> event.preventDefault()

    # Notify change handler
    $('#fulfill-order-scale-1-input').change (event) -> weightChanged()
    $('#fulfill-order-scale-2-input').change (event) -> weightChanged()

    # Intercept commit action and handle it with commit function
    $('#fulfill-order-commit').click (event) ->
      event.preventDefault()
      $('fulfill-order-commit').fadeOut()
      commit()

fulfillOrderScale1AutoRefresh = null
fulfillOrderScale2AutoRefresh = null

fulfillOrderStep1 = ->
  # Tare scales
  resetScale1()
  resetScale2()
  
  # Hide other steps
  $('#step-2').hide()
  $('#step-3').hide()
  $('#step-4').hide()
  $('.scale-display').hide()
  
  # Display UI
  setTimeout( ->
    $('#step-1').fadeIn()
  , 500)

  $('#fulfill-order-scan-jar-input').focus()

  # Stop reading
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

fulfillOrderStep2 = ->
  # Display UI
  $('#step-1').fadeOut -> $('#step-2').fadeIn()

  # Hide other steps
  $('#step-3').hide()
  $('#step-4').hide()
  $('.scale-display').hide()

  $('#fulfill-order-scan-bag-input').focus()

  # Stop reading
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

fulfillOrderStep3 = ->
  # Hide other steps
  $('#step-1').hide()
  $('#step-4').hide()

  # Display UI
  $('#step-2').fadeOut ->
    $('#step-3').fadeIn()
    $('.scale-display').fadeIn()

  # Tare scales
  resetScale1()
  resetScale2()

  # Start reading
  fulfillOrderScale1AutoRefresh = setInterval fulfillOrderReadScale1, 100
  fulfillOrderScale2AutoRefresh = setInterval fulfillOrderReadScale2, 100

fulfillOrderStep4 = ->
  # Hide other steps
  $('#step-1').hide()
  $('#step-2').hide()

  # Display UI
  $('#step-3').fadeOut ->
    $('#step-4').fadeIn()
    $('.scale-display').fadeIn()

  # Stop reading
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

resetScale1 = -> $.get('http://localhost:8080/zero')

resetScale2 = -> $.get('http://localhost:8081/zero')

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
  # WildCompass.Logger.debug "Fetching data from scale..."
  bagScaleText = $('#fulfill-order-scale-1-input').val().trim()
  jarScaleText = $('#fulfill-order-scale-2-input').val().trim()
  
  # WildCompass.Logger.debug "Parsing weights..."
  bagScaleCurrentReading = parseFloat(bagScaleText)
  jarScaleCurrentReading = parseFloat(jarScaleText)

  # WildCompass.Logger.debug "Pushing weights in buffer..."
  bagScaleReadings.push bagScaleCurrentReading
  jarScaleReadings.push jarScaleCurrentReading

  # WildCompass.Logger.debug "Removing oldest buffer values..."
  if bagScaleReadings.length > 30
    bagScaleReadings.shift()
  if jarScaleReadings.length > 30
    jarScaleReadings.shift()

  # WildCompass.Logger.debug "Displaying buffer..."
  # WildCompass.Logger.debug bagScaleReadings
  # WildCompass.Logger.debug jarScaleReadings

  # WildCompass.Logger.debug "Computing buffer averages..."
  bagWeightsSum = 0.0
  jarWeightsSum = 0.0
  # Sum of readings buffer
  bagWeightsSum += i for i in bagScaleReadings
  jarWeightsSum += j for j in jarScaleReadings
  # Average of readings buffer
  bagWeightsAverage = bagWeightsSum / bagScaleReadings.length
  jarWeightsAverage = jarWeightsSum / jarScaleReadings.length  

  # WildCompass.Logger.debug "Displaying buffer average..."
  # WildCompass.Logger.debug bagWeightsAverage
  # WildCompass.Logger.debug jarWeightsAverage
  
  # WildCompass.Logger.debug "Checking scale stability criteria..."
  if notNull() && isStable() && buffersFull() && inBounds() && weightMatches() && transactionMatches()
    transactionWeight = jarScaleCurrentReading
    fulfillOrderStep4()

  # WildCompass.Logger.debug "Saving previous weights for next iteration..."
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
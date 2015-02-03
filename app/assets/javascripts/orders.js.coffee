# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bagId = null
jarId = null
transactionWeight = null

$(document).ready ->

  bagId = $('#fulfill-order-bag').data('id')
  jarId = $('#fulfill-order-jar').data('id')
  jarQuantity = $('#fulfill-order-jar').data('quantity')

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

  fulfillOrderStep1()

fulfillOrderScale1AutoRefresh = null
fulfillOrderScale2AutoRefresh = null

fulfillOrderStep1 = ->
  $('#step-1').show()
  $('#step-2').hide()
  $('#step-3').hide()
  $('.scale-display').hide()
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

fulfillOrderStep2 = ->
  $('#step-1').hide()
  $('#step-2').show()
  $('#step-3').hide()
  $('.scale-display').hide()
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

fulfillOrderStep3 = ->
  # Display UI
  $('#step-1').hide()
  $('#step-2').hide()
  $('#step-3').show()
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
  $('.scale-display').show()
  # Stop reading
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)
  # Fulfill
  $.post(
    $('#fulfill-order').data('href'),
    order:
      bag: bagId
      jar: jarId
      weight: transactionWeight
  )

errorResetProcess = ->
  resetScale1()
  resetScale2()

resetScale1 = ->
  $.get 'http://localhost:8080/zero'

resetScale2 = ->
  $.get 'http://localhost:8081/zero'

# Scan bag's datamatrix
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
  $.get 'http://localhost:8080/data'
    .done (data) ->
      $('#fulfill-order-scale-1-input').val(data)
      $('#fulfill-order-scale-1-input').change

# Read data from scale 2
fulfillOrderReadScale2 = ->
  $.get 'http://localhost:8081/data'
    .done (data) ->
      $('#fulfill-order-scale-2-input').val(data)
      $('#fulfill-order-scale-2-input').change

weightChanged = ->
  bagWeight = parseFloat($('#fulfill-order-scale-1-input').val().trim())
  jarWeight = parseFloat($('#fulfill-order-scale-2-input').val().trim())
  if bagWeight + jarWeight <= 0.101 && bagWeight + jarWeight >= -0.101 && jarQuantity - jarWeight <= 0.101 && jarQuantity - jarWeight >= -0.101
    fulfillOrderStep4()
  else
    errorResetProcess()
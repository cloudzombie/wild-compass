# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

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

  fulfillOrderStep1()

  $('#fulfill-order-scan-jar-form').submit (event) ->
    event.preventDefault()
    fulfillScanJar()

  $('#fulfill-order-scan-bag-form').submit (event) ->
    event.preventDefault()
    fulfillScanBag()

fulfillOrderScale1AutoRefresh = null
fulfillOrderScale2AutoRefresh = null

fulfillOrderStep1 = ->
  $('#step-1').show()
  $('#step-2').hide()
  $('#step-3').hide()
  $('#scale-display').hide()
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

fulfillOrderStep2 = ->
  $('#step-1').hide()
  $('#step-2').show()
  $('#step-3').hide()
  $('#scale-display').hide()
  fulfillOrderScale1AutoRefresh = setInterval fulfillOrderReadScale1, 100
  fulfillOrderScale2AutoRefresh = setInterval fulfillOrderReadScale2, 100

fulfillOrderStep3 = ->
  $('#step-1').hide()
  $('#step-2').hide()
  $('#step-3').show()
  $('#scale-display').show()
  clearInterval(fulfillOrderScale1AutoRefresh)
  clearInterval(fulfillOrderScale2AutoRefresh)

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
      alert('BAG MATCH')
    else
      alert('BAG MISMATCH')

fulfillScanJar = ->
  $.post(
    $('#fulfill-order-scan-jar-input').data('href') + '.json',
    jar:
      scanned_hash: $('#fulfill-order-scan-jar-input').val()
    ).done (data) ->
      if data.jar.match
        alert('JAR MATCH')
      else
        alert('JAR MISMATCH')

# Read data from scale 1
fulfillOrderReadScale1 = ->
  $.get 'http://localhost:8080/data'
    .done (data) ->
      $('#fulfill-order-scale-1-readings').val(data)
      $('#fulfill-order-scale-1-readings').change()

# Read data from scale 2
fulfillOrderReadScale2 = ->
  $.get 'http://localhost:8081/data'
    .done (data) ->
      $('#fulfill-order-scale-2-readings').val(data)
      $('#fulfill-order-scale-2-readings').change()
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Page ready hook
$(document).ready ->

  # Toggle disabled on Reweight Button if scale 1 responds
  $.ajax(
    url: 'http://localhost:8080'
    type: 'GET'
    context: '.reweight'
    error: ->
      this.addClass('disabled')
      this.removeAttr('href')
      return
    success: ->
      this.removeClass('disabled')
      this.attr('href', this.data('href'))
      return
    ).done (data) ->
      console.log("TOGGLE REWEIGHT BUTTON :", data)
      return

  # Zero scale 1
  $("#reweight-zero-scale-1-btn").click (event) ->
    event.preventDefault()
    reweightResetScale1()
    return

  reweightBagStep1()

  # Detect bag id
  $('#reweight-bag-scan').submit (event) ->
    event.preventDefault()
    oldScanBag()
    return

  # Detect weight change
  $('#reweight-bag-scale-1-readings').change (event) ->
    if bag.readings == parseInt($('#reweight-bag-scale-1-readings').text())
      bag.count += 1
      if bag.count >= 30
        reweightBagStep3()
    else
      bag.readings = parseInt($('#reweight-bag-scale-1-readings').text())
    return

reweightBagStep1 = ->
  state = 'step-1'
  $('#reweight-bag-step-1').show()
  $('#reweight-bag-step-2').hide()
  $('#reweight-bag-step-3').hide()
  $('#reweight-bag-scale-display').hide()
  return

reweightBagStep2 = ->
  state = 'step-2'
  $('#reweight-bag-step-1').hide()
  $('#reweight-bag-step-2').show()
  $('#reweight-bag-step-3').hide()
  $('#reweight-bag-scale-display').show()
  return

reweightBagStep3 = ->
  state = 'step-3'
  $('#reweight-bag-step-1').hide()
  $('#reweight-bag-step-2').hide()
  $('#reweight-bag-step-3').show()
  $('#reweight-bag-scale-display').hide()  
  return

reweightErrorResetProcess = ->
  reweightBagStep1
  reweightResetScale1
  return

reweightResetScale1 = ->
  $.ajax(
    url: ReweightScale.SCALE1_URL + '/zero'
  ).done (data) ->
    console.log("RESET SCALE 1 : ", data)
    return
  return

scanBag = ->
  $.ajax(
    url: "<%= scan_bag_path(bag) %>"
    type: "POST"
  ).done (data) ->
    console.log("RESPONSE : ", data)
    return
  return

oldScanBag = =>
  $.ajax
    url: '/bags/' + $('#reweight-bag').val() + '.json'
    type: 'GET'
    error: ->
      reweightErrorResetProcess()
      return
    success: (data) ->
      reweightBagStep2()
      return
  return
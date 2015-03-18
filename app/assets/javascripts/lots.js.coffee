# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

autoRefreshScale1 = null
autoRefreshScale2 = null

process = null

bag = null

$(document).ready ->
  $('#lot_container_ids').select2({
    
  })

  return

class Lot
  # Scan bag's datamatrix
  scanBag: ->
    $.post(
      $('#scanned_hash').data('href') + '.json', scanned_hash: $('#scanned_hash').val()
    ).done( (data) ->
      bag = data
      if data.lot_id == $('#lot').data('id')
        $('#scanner').fadeOut ->
          $('#scannable').fadeIn()
          $('#relot-step-1').fadeIn()
          process = new Relot
          process.step1()
        $('#box-description-title').text(data.name)
        $('#box-description-id').text(data.name)
        $.each(data, (key, value) ->
          if key == 'location'
            if value == null
              $('#box-description-table').append("<tr><th>LOCATION : </th><td></td></tr>")
            else
              $('#box-description-table').append("<tr><th>LOCATION : </th><td>" + value.name + "</td></tr>")
          else if key == 'container_id'
            $.get('/containers/' + value + '.json').done (data) ->
              $('#box-description-table').append("<tr><th>CONTAINER : </th><td><a href=\"/containers/" + data.id + "\" >" + data.name + "</a></td></tr>")
          else if key == 'bags_status_id'
            if value == null
              $('#box-description-table').append("<tr><th>STATUS : </th><td></td></tr>")
            else
              $('#box-description-table').append("<tr><th>STATUS : </th><td>" + value.name + "</td></tr>")
          else if key == 'strain'
            $('#box-description-table').append("<tr><th>" + key.replace(/_/g, ' ').toUpperCase() + " : </th><td>" + value.acronym + "</td></tr>")
          else if key != 'id' && key != 'name' && key != 'delta' && key != 'delta_old' && key != 'variance' && key != 'archived' && key != 'tare_weight' && key != 'sent_to_lab' && key != 'datamatrix_text' && key != 'datamatrix_hash' && key != 'origin' && key != 'history_id' && key != 'tested' && key != 'packaged_at'
            $('#box-description-table').append("<tr><th>" + key.replace(/_/g, ' ').toUpperCase() + " : </th><td>" + value + "</td></tr>")
        )
      else
        alert('Bag is not in current lot!')
      return
    ).error( (data) ->
      console.log data
      if data.status == 404
        alert("404 - Record Not Found")
      else if data.status == 500
        alert("500 - Application Error")
      else
        alert(data.status)
    )
    return

class Relot
  step1: ->
    autoRefreshScale1 = setInterval(readScale1, 100)
    autoRefreshScale2 = setInterval(readScale2, 100)

  # Read data from scale 1
  readScale1 = ->
    $.get('http://localhost:8080/data').done (data) ->
      $('#scale-display-1').val(data)
      $('#scale-display-1').change()
  
  # Read data from scale 2
  readScale2 = ->
    $.get('http://localhost:8081/data').done (data) ->
      $('#scale-display-2').val(data)
      $('#scale-display-2').change()

  step2: ->
    
    return

class LotsController
  init: ->
    console.log 'lots#init'
    return

  relot: ->
    console.log 'lots#relot'
    $(document).ready ->
      
      # Detect bag id
      $('#scan-form').submit (event) ->
        event.preventDefault()
        lot = new Lot
        lot.scanBag()
        return

      $('#scale-display-1').change ->
        if Math.abs(parseFloat($('#scale-display-1').val().trim()) - parseFloat(bag.current_weight)) < 0.101
          $('#relot-transaction-source').val(bag.id)
          $('#relot-transaction-weight').val(parseFloat($('#scale-display-1').val().trim()))
          $('#relot-step-1').fadeOut ->
            $('#relot-step-2').fadeIn()
          clearInterval(autoRefreshScale1)
          clearInterval(autoRefreshScale2)
          process.step2()
        else if Math.abs(parseFloat($('#scale-display-1').val().trim()) - parseFloat(bag.current_weight)) < 5.101
          alert "Bag weight doesn't match inventory weight"

      return
    return

this.WildCompass.lots = new LotsController
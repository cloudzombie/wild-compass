# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#lot_container_ids').select2({
    
  })

  return

# Scan bag's datamatrix
class Lot
  scanBag: ->
    $.post(
      $('#scanned_hash').data('href') + '.json', scanned_hash: $('#scanned_hash').val()
    ).done (data) ->
      $('#scanner').fadeOut ->
        $('#scannable').fadeIn()
        $('#relot-step-1').fadeIn()
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
      return
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

      return
    return

this.WildCompass.lots = new LotsController
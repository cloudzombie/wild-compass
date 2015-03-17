# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Scanner
  # Scan bag's datamatrix
  scan: ->
    $.post(
      $('#scanned_hash').data('href') + '.json', scanned_hash: $('#scanned_hash').val()
    ).done (data) ->
      console.log(data)
      $('#scanner').fadeOut ->
        $('#scannable').fadeIn()
      $('#box-description-title').text(data.name)
      $('#box-description-id').text(data.name)
      $.each(data, (key, value) ->
        $('#box-description-table').append("<tr><th>" + key.toUpperCase() + " : </th><td>" + value + "</td></tr>")
      )
      return
    return

class ScanController
  init: ->
    console.log 'scan#init'
    return

  scan: ->
    console.log 'scan#scan'
    $(document).ready ->
      
      # Detect bag id
      $('#scan-form').submit (event) ->
        event.preventDefault()
        scanner = new Scanner
        scanner.scan()
        return

      return
    return

this.WildCompass.scan = new ScanController
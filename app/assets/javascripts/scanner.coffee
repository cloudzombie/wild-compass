this.WildCompass.Scanner = class Scanner
  # Scan bag's datamatrix
  scan: ->
    $.post $('#scanned_hash').data('href') + '.json', scanned_hash: $('#scanned_hash').val(), (data) ->
      console.log(data)
      $('#scanner').fadeOut -> $('#scannable').fadeIn()
      $('#box-description-title').text(data.name)
      $('#box-description-id').text(data.name)
      $.each data, (key, value) -> $('#box-description-table').append("<tr><th>" + key.toUpperCase() + " : </th><td>" + value + "</td></tr>")

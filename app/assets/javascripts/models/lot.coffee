this.WildCompass.Lot = class Lot
  @find: (id, fn) ->
    $.getJSON "/lots/" + id + ".json", (data) -> fn(data)

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
    
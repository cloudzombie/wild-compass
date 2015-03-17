class ScaleController
  init: ->
    console.log 'scale#init'
    return

  scale: ->
    console.log 'scale#scale'
    $(document).ready ->
      autoRefreshScale1 = setInterval(readScale1, 100)
      autoRefreshScale2 = setInterval(readScale2, 100)
      return
    return

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

this.WildCompass.scale = new ScaleController
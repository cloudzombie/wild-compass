class Scale
  # Read data from scale 1
  readScale1 = ->
    alert('werk')
    $.get('http://localhost:8080/data').done (data) ->
      $('#scale-display-1').val(data)
      $('#scale-display-1').change()
    return
  
  # Read data from scale 2
  readScale2 = ->
    alert('work')
    $.get('http://localhost:8081/data').done (data) ->
      $('#scale-display-2').val(data)
      $('#scale-display-2').change()
    return

class ScaleController
  init: ->
    console.log 'scale#init'
    return

  scale: ->
    console.log 'scale#scale'
    $(document).ready ->
      s = new Scale
      scale1Interval = setInterval(s.readScale1, 100)
      scale2Interval = setInterval(s.readScale2, 100)
      return
    return

this.WildCompass.scale = new ScaleController
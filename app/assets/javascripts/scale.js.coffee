# Default scales URL (from the client perspective)
SCALE1_URL = "http://localhost:8080"
SCALE2_URL = "http://localhost:8081"

# Default selector to update weights display
SCALE1_SELECTOR = "#scale-display-1"
SCALE2_SELECTOR = "#scale-display-2"

class Scale
  constructor: (@url) ->

  start: (selector) ->
    @autoRefresh = setInterval(read(selector), 100)
    return

  stop: ->
    clearInterval(@autoRefresh)
    return

  read: (selector) ->
    $.get(SCALE1_URL + "/data").done (data) ->
      $(selector).val(data)
      $(selector).change()

class ScaleController
  init: ->
    console.log 'scale#init'
    @scale1 = new Scale(SCALE1_URL)
    @scale2 = new Scale(SCALE2_URL)
    return

  scale: ->
    console.log 'scale#scale'
    @scale1.start(SCALE1_SELECTOR)
    @scale2.start(SCALE2_SELECTOR)
    return

this.WildCompass.scale = new ScaleController
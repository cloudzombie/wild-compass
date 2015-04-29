# Default scales URL (from the client perspective)
SCALE1_URL = "http://localhost:8080"
SCALE2_URL = "http://localhost:8081"

# Default selector to update weights display
SCALE1_SELECTOR = "#scale-display-1"
SCALE2_SELECTOR = "#scale-display-2"

# Interval time
HUNDRED_MILLISECONDS = 100
 
# Reusable code for handling scales
this.WildCompass.Scale = class Scale
  @find: (id, fn) -> $.getJSON "/scales/" + id + ".json", (data) -> fn(data)

  constructor: (@url, @selector) ->

  # starts reading data from scale
  start: ->
    @autoRefresh = setInterval(this.read, HUNDRED_MILLISECONDS)
    return

  # stops reading data from scale
  stop: ->
    clearInterval(@autoRefresh)
    return

  # Read data callback
  read: =>
    console.log 'Reading scale (' + @url + ') data...'
    $.get(@url + "/data").done (data) =>
      console.log 'Read: ' + data
      $(@selector).val(data)
      $(@selector).change()
      return
    return
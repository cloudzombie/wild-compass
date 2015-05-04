# Properly instantiates scales for scales controller
this.WildCompass.ScalesController = class ScalesController
  init: ->
    console.log 'scale#init'
    @scale1 = new Scale(SCALE1_URL, SCALE1_SELECTOR)
    @scale2 = new Scale(SCALE2_URL, SCALE2_SELECTOR)
    return

  scale: ->
    console.log 'scale#scale'
    @scale1.start()
    @scale2.start()
    return

# Register controller with application
this.WildCompass.scales = new ScalesController
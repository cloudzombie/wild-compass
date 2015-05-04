# Use as a namespace
this.WildCompass ?= {}
this.WildCompass.env ?= {}

(($) ->
  $ ->
    $body = $('body')
    controller = $body.data('controller').replace(/\//g, '_')
    action = $body.data('action')
    activeController = WildCompass[controller]
    if activeController != undefined
      if $.isFunction(activeController.init)
        activeController.init()
      if $.isFunction(activeController[action])
        activeController[action]()
    return
  return
) jQuery
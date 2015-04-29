# Use as a namespace
this.WildCompass ?= {}

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

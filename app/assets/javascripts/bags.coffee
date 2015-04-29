# default scale url
SCALE1_URL = "http://localhost:8080"

# default reweight scale selector
REWEIGHT_SELECTOR = "#reweight-bag-scale-1-readings"

this.WildCompass.Reweight = class Reweight
  constructor: ->
    # Instantiate a scale
    @scale = new WildCompass.Scale(SCALE1_URL, REWEIGHT_SELECTOR)

  # Step 1 of reweight process
  step1: ->
    $('#reweight-bag-step-1').show()
    $('#reweight-bag-step-2').hide()
    $('#reweight-bag-step-3').hide()
    $('#reweight-bag-scale-display').hide()
    @scale.stop()
    return

  # Step 2 of reweight process
  step2: ->
    $('#reweight-bag-step-1').hide()
    $('#reweight-bag-step-2').show()
    $('#reweight-bag-step-3').hide()
    $('#reweight-bag-scale-display').show()
    @scale.start()
    return

  # Step 3 of reweight process
  step3: ->
    $('#reweight-bag-step-1').hide()
    $('#reweight-bag-step-2').hide()
    $('#reweight-bag-step-3').show()
    $('#reweight-bag-tare-weight').focus()
    @scale.stop()
    return

  # Reset Reweight Process
  reset: ->
    this.step1()
    return

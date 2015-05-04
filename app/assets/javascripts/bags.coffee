# default scale url
SCALE1_URL     = "http://localhost:8080"
STEP1_SELECTOR = "#reweight-bag-step-1"
STEP2_SELECTOR = "#reweight-bag-step-2"
STEP3_SELECTOR = "#reweight-bag-step-3"
SCALE_SELECTOR = "#reweight-bag-scale-display"
REWEIGHT_SELECTOR = "#reweight-bag-scale-1-readings"
TARE_SELECTOR = '#reweight-bag-tare-weight'

this.WildCompass.Reweight = class Reweight
  constructor: ->
    # Instantiate a scale
    @scale = new WildCompass.Scale(SCALE1_URL, REWEIGHT_SELECTOR)
    $(STEP1_SELECTOR).show()
    $(STEP2_SELECTOR).hide()
    $(STEP3_SELECTOR).hide()

  # Step 1 of reweight process
  step1: ->
    $(STEP2_SELECTOR).fadeOut -> $(STEP1_SELECTOR).fadeIn()
    $(STEP3_SELECTOR).fadeOut -> $(STEP1_SELECTOR).fadeIn()
    $(SCALE_SELECTOR).fadeOut -> $(STEP1_SELECTOR).fadeIn()
    @scale.stop()

  # Step 2 of reweight process
  step2: ->
    $(STEP1_SELECTOR).fadeOut ->
      $(STEP2_SELECTOR).fadeIn()
      $(SCALE_SELECTOR).fadeIn()
    $(STEP3_SELECTOR).fadeOut ->
      $(STEP2_SELECTOR).fadeIn()
      $(SCALE_SELECTOR).fadeIn()
    @scale.start ->
      $(REWEIGHT_SELECTOR).val(data)
      $(REWEIGHT_SELECTOR).change()

  # Step 3 of reweight process
  step3: ->
    $(STEP1_SELECTOR).fadeOut -> $(STEP3_SELECTOR).fadeIn()
    $(STEP2_SELECTOR).fadeOut -> $(STEP3_SELECTOR).fadeIn()
    $(TARE_SELECTOR).focus()
    @scale.stop()

  # Reset Reweight Process
  reset: -> @::step1

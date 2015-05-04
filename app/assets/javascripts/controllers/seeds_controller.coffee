this.WildCompass.SeedsController = class SeedsController
  init: ->
    console.log 'seeds#init'

  index: ->
    console.log 'seeds#index'
    # Toggle disabled on reweight button if scale responds
    $.get 'http://localhost:8080'
      .fail ->
        $('.reweight').prop('disabled', true)
        $('.reweight').removeAttr('href')
      .done ->
        $('.reweight').prop('disabled', false)
        # $('.reweight').attr('href', this.data('href'))

  show: ->
    console.log 'seeds#show'

  new: ->
    console.log 'seeds#new'

  edit: ->
    console.log 'seeds#edit'

  reweight: ->
    console.log 'seeds#reweight'
    
    # Detect seed id
    $('#reweight-seed-scan').submit (event) ->
      event.preventDefault()
      scanSeed()

    $('#reweight-seed-weight').submit (event) ->
      message = $('#reweight-seed-message')
      if message && message.val()
        return
      else
        event.preventDefault()

    # Detect weight change
    $('#reweight-seed-scale-1-readings').change (event) ->
      weight = parseFloat($('#reweight-seed-scale-1-readings').val().trim())
      reweightSeedStep3()
      $('#reweight-seed-scale-1-readings').val(weight)

    reweightSeedStep1()

this.WildCompass.seeds = new SeedsController

this.WildCompass.LotsController = class LotsController
  init: ->
    console.log 'lots#init'

  index: ->
    console.log 'lots#index'
    # Get index of parent TD among its siblings (add one for nth-child)
    #$("#origin").hide()
    $('td:nth-child(2)').hide()

  new: ->
    console.log 'lots#new'

  edit: ->
    console.log 'lots#edit'

  show: ->
    console.log 'lots#show'

  relot: ->
    console.log 'lots#relot'
      
    # Detect bag id
    $('#scan-form').submit (event) ->
      event.preventDefault()
      lot = new Lot
      lot.scanBag()

    $('#scale-display-1').change ->
      if Math.abs(parseFloat($('#scale-display-1').val().trim()) - parseFloat(bag.current_weight)) < 0.101
        $('#relot-transaction-source').val(bag.id)
        $('#relot-transaction-weight').val(parseFloat($('#scale-display-1').val().trim()))
        $('#relot-step-1').fadeOut -> $('#relot-step-2').fadeIn()
        clearInterval(autoRefreshScale1)
        clearInterval(autoRefreshScale2)
        process.step2()
      else if Math.abs(parseFloat($('#scale-display-1').val().trim()) - parseFloat(bag.current_weight)) < 5.101
        alert "Bag weight doesn't match inventory weight"

this.WildCompass.lots = new LotsController
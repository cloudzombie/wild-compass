this.WildCompass.Bag = class Bag
  @find: (id, fn) ->
    $.getJSON "/bags/" + id + ".json", (data) -> fn(data)

  constructor: ->
    @reweight = new WildCompass.Reweight

  startReweight: ->
    @reweight.step1()
    return

  # Scan bag's datamatrix
  scan: ->
    $.post(
      $('#reweight-bag').data('href') + '.json',
      bag:
        scanned_hash: $('#reweight-bag').val()
    ).done (data) =>
      if data.bag.match
        @reweight.step2()
      else
        @reweight.reset()
    return
    
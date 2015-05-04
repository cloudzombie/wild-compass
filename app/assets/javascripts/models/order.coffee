# Instantiate an order from rails model
this.WildCompass.Order = class Order
  @find: (id, fn) ->
    $.getJSON "/orders/" + id + ".json", (data) -> fn(data)
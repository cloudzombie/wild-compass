this.WildCompass.Bin = class Bin
  @find: (id, fn) ->
    $.getJSON "/bins/" + id + ".json", (data) -> fn(data)
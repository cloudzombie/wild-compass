this.WildCompass.Logger = class Logger
  @info: (message) ->
    $.post "/logger/info.json", { "log[message]": message }
    if WildCompass.env.development
      console.log message
  
  @debug: (message) ->
    $.post "/logger/debug.json", { "log[message]": message }
    if WildCompass.env.development
      console.log message

  @error: (message) ->
    $.post "/logger/error.json", { "log[message]": message }
    if WildCompass.env.development
      console.log message

  @warn: (message) ->
    $.post "/logger/warn.json", { "log[message]": message }
    if WildCompass.env.development
      console.log message

  @fatal: (message) ->
    $.post "/logger/fatal.json", { "log[message]": message }
    if WildCompass.env.development
      console.log message

  @unknown: (message) ->
    $.post "/logger/unknown.json", { "log[message]": message }
    if WildCompass.env.development
      console.log message

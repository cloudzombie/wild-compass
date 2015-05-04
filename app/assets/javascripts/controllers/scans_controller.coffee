this.WildCompass.ScansController = class ScansController
  init: ->
    console.log 'scan#init'

  scan: ->
    console.log 'scan#scan'
      
    # Detect bag id
    $('#scan-form').submit (event) ->
      event.preventDefault()
      scanner = new Scanner
      scanner.scan()

this.WildCompass.scans = new ScansController
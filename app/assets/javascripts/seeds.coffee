# Enable select2 form for seeds plants
$(document).ready -> $('#seed_plant_ids').select2({})

scale1AutoRefresh = null

# Step 1 of reweight process
reweightSeedStep1 = ->
  $('#reweight-seed-step-1').show()
  $('#reweight-seed-step-2').hide()
  $('#reweight-seed-step-3').hide()
  $('#reweight-seed-scale-display').hide()
  clearInterval(scale1AutoRefresh)

# Step 2 of reweight process
reweightSeedStep2 = ->
  $('#reweight-seed-step-1').hide()
  $('#reweight-seed-step-2').show()
  $('#reweight-seed-step-3').hide()
  $('#reweight-seed-scale-display').show()
  scale1AutoRefresh = setInterval readScale1, 100

# Step 3 of reweight process
reweightSeedStep3 = ->
  $('#reweight-seed-step-1').hide()
  $('#reweight-seed-step-2').hide()
  $('#reweight-seed-step-3').show()
  clearInterval(scale1AutoRefresh)

# Reset Reweight Process
reweightErrorResetProcess = ->
  reweightSeedStep1()

# Scan seed's datamatrix
scanSeed = ->
  $.post(
    $('#reweight-seed').data('href') + '.json',
    seed:
      scanned_hash: $('#reweight-seed').val()
  ).done (data) ->
    if data.seed.match
      reweightSeedStep2()
    else
      reweightErrorResetProcess()

# Read data from scale 1
readScale1 = ->
  $.get('http://localhost:8080/data').done (data) ->
    $('#reweight-seed-scale-1-readings').val(data)
    $('#reweight-seed-scale-1-readings').change()

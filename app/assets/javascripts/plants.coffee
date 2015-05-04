# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#plant-type').change ->
    if this.value == 'Plant'
      showSeedOrigin()
      hidePlantOrigin()
    if this.value == 'Plant::MotherPlant'
      showSeedOrigin()
      hidePlantOrigin()
    if this.value == 'Plant::ClonePlant'
      showPlantOrigin()
      hideSeedOrigin()
    if this.value == 'Plant::BabyPlant'
      showPlantOrigin()
      hideSeedOrigin()
    return
  $('#plant-type').change()
  return

hidePlantOrigin = ->
  $('#plant-origin').prop('disabled', true)
  $('#plant-origin-container').hide()
  return

showPlantOrigin = ->
  $('#plant-origin').prop('disabled', false)
  $('#plant-origin-container').show()
  return

hideSeedOrigin = ->
  $('#seed-origin').prop('disabled', true)
  $('#seed-origin-container').hide()
  return

showSeedOrigin = ->
  $('#seed-origin').prop('disabled', false)
  $('#seed-origin-container').show()
  return
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#format-filter').change ->
    $.get $('#format-filter').data('url')

  $('#strain-filter').change ->
    $.get $('#strain-filter').data('url')

  $('#status-filter').change ->
    $.get $('#status-filter').data('url')
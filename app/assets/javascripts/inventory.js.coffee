# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#id-filter').change ->
    $('filter-form').submit

  $('#format-filter').change ->
    $('filter-form').submit

  $('#strain-filter').change ->
    $('filter-form').submit

  $('#status-filter').change ->
    $('filter-form').submit

  $('#type-filter').change ->
    $('filter-form').submit

  $("#table-form").on("ajax:success", (e, data, status, xhr) ->
    $("#table-form").append xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#table-form").append "<p>ERROR</p>"
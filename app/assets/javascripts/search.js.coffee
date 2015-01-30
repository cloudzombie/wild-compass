$ ->
  $(document).on "click", "#sort th a", ->
    $.getScript @href
    false

  $("#search_form input").keyup ->
    $.get $("#search_form").attr("action"), $("#search_form").serialize(), null, "script"
    false

  return
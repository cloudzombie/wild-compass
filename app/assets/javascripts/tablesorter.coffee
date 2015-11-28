$(document).ready ->
  $ -> $.extend $.tablesorter.defaults, widgets: [ "zebra", "columns" ]
  $("table.accounts").tablesorter()

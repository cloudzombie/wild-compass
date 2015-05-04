$(document).ready ->
  $ ->
    $.extend $.tablesorter.defaults,
      widgets: [
        "zebra"
        "columns"
      ]

    $("#timeline").tablesorter({
      dateFormat : "mmddyyyy"
      headers: {
        0: {
          sorter: "shortDate"
        }
      }
      sortList: [[0,0]]
      theme: 'blue'
    })

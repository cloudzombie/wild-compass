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
        2: {
          sorter: false
        }
        4: {
          sorter: false
        }
      }
      sortList: [[0,0]]
      theme: 'blue'
    })

    return
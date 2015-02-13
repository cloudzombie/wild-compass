$(document).ready ->
  $ ->
    $.extend $.tablesorter.defaults,
      widgets: [
        "zebra"
        "columns"
      ]

    $("#timeline").tablesorter({
      headers: {
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
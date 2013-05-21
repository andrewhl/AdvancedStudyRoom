$ ->

  $('.results-table td.result').hover ->
    classes = $(@).attr 'class'
    row = classes.match(/row\-\d+/)[0]
    col = classes.match(/column\-\d+/)[0]
    $('.' + col).toggleClass "dark-cell"

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.results-table td.result').mouseover ->
  classes = $(@).attr 'class'
  row_class = classes.match(/row\-\d+/)[0]
  col_class = classes.match(/column\-\d+/)[0]
  $(col_class).addClass "dark-cell"



loadingHTML = "<div class='loading'>Loading...</div>"

$ ->
  $('.secondary-content').html loadingHTML

$('.whiteout').click ->
  $('.secondary-content').html loadingHTML
  $('.whiteout').hide()
  $('.secondary-content').removeClass 'sliding-in'

$('.view-discussion > a').click (e) ->
  $('.secondary-content').html loadingHTML
  $('.secondary-content').addClass 'sliding-in'
  e.preventDefault()
  $.ajax($(this).attr('href')).complete (data) ->
    $('.whiteout').show()
    $('.secondary-content').html data.responseText

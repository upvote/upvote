loadingHTML = "<div class='loading'>Loading...</div>"
errorHTML = "<div class='loading'>D'oh, we couldn't find that.</div>"

openURLInPanel = (urlOrPath) ->
  window.location.hash = "#!#{urlOrPath}"
  $('.secondary-content').html loadingHTML
  $('.secondary-content').addClass 'sliding-in'
  $.ajax(urlOrPath).success((data) ->
    $('.whiteout').show()
    $('.secondary-content').html data.responseText
  ).error((data) ->
    $('.whiteout').show()
    $('.secondary-content').html errorHTML
  ).complete((data) ->
    $('.whiteout').show()
    $('.secondary-content').html data.responseText
  )

hidePanel = ->
  window.location.hash = ''
  $('.secondary-content').html loadingHTML
  $('.whiteout').hide()
  $('.secondary-content').removeClass 'sliding-in'

$ ->
  $('.secondary-content').html loadingHTML

  if document.location.hash.substr(0,2) == '#!'
    openURLInPanel document.location.hash.substr(2)

  $('.whiteout').click hidePanel

  $('.view-discussion > a,a[data-secondary]').click (e) ->
    e.preventDefault()
    openURLInPanel $(this).attr('href')

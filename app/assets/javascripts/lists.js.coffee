class Lists
  renderLists: () ->
    lists = $('<div class=lists>')
    title = $('<h1>Your Lists</h1>')

    lists.append(title)
    $('body').html(lists)

$ ->
  window.Lists = new Lists

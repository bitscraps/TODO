class Lists
  renderLists: () ->
    lists = $('<div class=lists>')
    title = $('<h1>Your Lists</h1>')

    lists.append(title)
    $('body').html(lists)

    $.get('/api/lists')
    .done( (data)=>
      $.each(data, (index, list)=>
        this.renderListBlock(list)
      )
    )

  renderListBlock: (list) ->
    $('body').append('<div>'+list.name+'</div>')

$ ->
  window.Lists = new Lists

class Lists
  renderLists: () ->
    lists = $('<div class=lists>')
    title = $('<h1>Your Lists</h1>')

    lists.append(title)
    $('body').html(lists)

    new_list = $('<button>Create a new list</button>')
    new_list.on('click', =>
      this.renderNewListForm()
    )
    lists.append(new_list)

    $.get('/api/lists')
    .done( (data)=>
      $.each(data, (index, list)=>
        this.renderListBlock(list)
      )
    )

  renderListBlock: (list) ->
    $('body').append('<div>'+list.name+'</div>')

  renderNewListForm: ->
    form = $('<div class="list_form"></div>')

    name_label = $('<label>Name</label>')
    form.append(name_label)

    name = $('<input name=list[name] id="list_name">')
    form.append(name)

    createButton = $('<button>Create List</button>')
    createButton.on('click', =>
      $.post('/api/lists',
        list: { name: $('#list_name').prop('value') }
      ).done( ->
        window.Lists.renderLists()
      ).fail( ->
        $('body').append($('<div class="error">Unable to create list</div>'))
      )
    )
    form.append(createButton)

    $('body').append(form)

$ ->
  window.Lists = new Lists

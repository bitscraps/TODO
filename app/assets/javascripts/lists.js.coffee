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
    list_item = $('<div class="list" data-id='+list.id+'>'+list.name+'</div>')
    this_list = this

    archive = $('<a href="#" data-id='+list.id+'>Archive List</div>')
    archive.on('click', (event)->
      event.stopPropagation()
      this_list.archiveList(this)
    )

    list_item.append(archive)

    change_name = $('<a href="#" data-id='+list.id+' data-name="'+list.name+'">Change Name</div>')
    change_name.on('click', (event)->
      event.stopPropagation()
      this_list.renderChangeListForm(this)
    )

    list_item.append(change_name)

    list_item.on('click', ->
      window.Tasks.renderTasks($(this).data('id'))
    )

    $('body').append(list_item)


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

  renderChangeListForm: (click)->
    form = $('<div class="form"></div>')

    name_label = $('<label>Name</label>')
    form.append(name_label)

    name = $('<input name=list[name] id="list_name" value="'+$(click).data('name')+'">')
    form.append(name)

    createButton = $('<button>Change Name</button>')
    createButton.on('click', =>
      $.ajax('/api/lists/'+$(click).data('id'),
        data: { list: { name: $('#list_name').prop('value') }  }
        type: 'PUT'
      ).done( ->
        window.Lists.renderLists()
      ).fail( ->
        $('body').append($('<div class="error">Unable to change list name</div>'))
      )
    )
    form.append(createButton)

    $('body').append(form)

  archiveList: (click)->
    $.ajax('/api/lists/'+$(click).data('id'),
      type: 'DELETE'
    ).done(=>
      @.renderLists()
    )

$ ->
  window.Lists = new Lists

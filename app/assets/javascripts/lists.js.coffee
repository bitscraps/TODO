class Lists
  renderLists: () ->
    lists = $('<div class=lists>')

    $('.title').html('Your Lists')
    $('.content').html(lists)

    new_list = $('<a href=# >Create a new list</a>')
    new_list.on('click', =>
      this.renderNewListForm()
    )
    $('.right-action').html(new_list)

    $.get('/api/lists')
    .done( (data)=>
      $.each(data, (index, list)=>
        this.renderListBlock(list)
      )
    )

    $('.left-action').html('')

  renderListBlock: (list) ->
    list_item = $('<div class="list" data-id='+list.id+'><span>'+list.name+'</span></div>')
    this_list = this

    actions = $('<div class="actions"></div>')

    archive = $('<a href="#" data-id='+list.id+'>Archive List</div>')
    archive.on('click', (event)->
      event.stopPropagation()
      this_list.archiveList(this)
    )

    actions.append(archive)

    change_name = $('<a href="#" data-id='+list.id+' data-name="'+list.name+'">Change Name</div>')
    change_name.on('click', (event)->
      event.stopPropagation()
      this_list.renderChangeListForm(this)
    )

    actions.append(change_name)

    list_item.on('click', ->
      window.Tasks.renderTasks($(this).data('id'))
    )

    list_item.append(actions)

    $('.content').append(list_item)


  renderNewListForm: ->
    form = $('<div class="form"></div>')

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
        $('.content').append($('<div class="error">Unable to create list</div>'))
      )
    )
    form.append(createButton)

    close = $("<a href=# class='close'>Cancel</a>")
    close.on('click', ->
      $('.overlay').remove()
      $('.form').remove()
    )
    form.append(close)

    $('.content').append("<div class='overlay'></div>")
    $('.content').append(form)

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
        $('.content').append($('<div class="error">Unable to change list name</div>'))
      )
    )
    form.append(createButton)

    close = $("<a href=# class='close'>Cancel</a>")
    close.on('click', ->
      $('.overlay').remove()
      $('.form').remove()
    )
    form.append(close)

    $('.content').append("<div class='overlay'></div>")
    $('.content').append(form)

  archiveList: (click)->
    $.ajax('/api/lists/'+$(click).data('id'),
      type: 'DELETE'
    ).done(=>
      @.renderLists()
    )

$ ->
  window.Lists = new Lists

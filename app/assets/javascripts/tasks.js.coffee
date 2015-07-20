class Tasks
  renderTasks: (list) ->
    this.list = list
    tasks = $('<div class=tasks>')

    $('.title').html('Your Tasks')
    $('.content').html(tasks)

    new_task = $('<a href=#>Create a new task</a>')
    new_task.on('click', =>
      this.renderNewTaskForm()
    )
    $('.right-action').html(new_task)

    back_to_list = $('<a href=#>back to lists</a>')
    back_to_list.on('click', =>
      window.Lists.renderLists()
    )
    $('.left-action').html(back_to_list)

    $.get('/api/lists/'+list+'/tasks')
    .done( (data)=>
      $.each(data, (index, task)=>
        this.renderTaskBlock(task)
      )
    )

  renderTaskBlock: (task) ->
    this_task = this
    task_item = $('<div class="task" id="task'+task.id+'"">'+task.name+'</div>')

    actions = $('<div class="actions"></div>')

    if task.complete
      task_item.addClass('complete')

    complete = $('<a href="#" data-id='+task.id+' id="task='+task.id+'">Complete</div>')
    complete.on('click', (event)->
      event.stopPropagation()
      this_task.completeTask(this)
    )

    actions.append(complete)

    change_name = $('<a href="#" data-id='+task.id+' data-name="'+task.name+'">Change Name</div>')
    change_name.on('click', (event)->
      event.stopPropagation()
      this_task.renderChangeTaskForm(this)
    )

    actions.append(change_name)
    task_item.append(actions)

    $('.tasks').append(task_item)

  renderNewTaskForm: ->
    this_task = this
    form = $('<div class="form"></div>')

    task_label = $('<label>Name</label>')
    form.append(task_label)

    name = $('<input name=task[name] id="task_name">')
    form.append(name)

    createButton = $('<button>Create Task</button>')
    createButton.on('click', =>
      $.post('/api/lists/'+this.list+'/tasks',
        task: { name: $('#task_name').prop('value') }
      ).done( =>
        this_task.renderTasks(this.list)
      ).fail( ->
        $('.content').append($('<div class="error">Unable to create task</div>'))
      )
    )
    form.append(createButton)

    close = $("<a href=# class='close'>Cancel</a>")
    close.on('click', ->
      $('.overlay').remove()
      $('.form').remove()
    )
    form.append(close)

    $('.content').append('<div class="overlay"></div>')
    $('.content').append(form)

  renderChangeTaskForm: (click)->
    form = $('<div class="form"></div>')

    name_label = $('<label>Name</label>')
    form.append(name_label)

    name = $('<input name=task[name] id="task_name" value="'+$(click).data('name')+'">')
    form.append(name)

    createButton = $('<button>Change Name</button>')
    createButton.on('click', =>
      $.ajax('/api/lists/'+this.list+'/tasks/'+$(click).data('id'),
        data: { task: { name: $('#task_name').prop('value') }  }
        type: 'PUT'
      ).done( =>
        @.renderTasks(@.list)
      ).fail( ->
        $('.content').append($('<div class="error">Unable to change task name</div>'))
      )
    )
    form.append(createButton)

    close = $("<a href=# class='close'>Cancel</a>")
    close.on('click', ->
      $('.overlay').remove()
      $('.form').remove()
    )
    form.append(close)

    $('.content').append('<div class="overlay"></div>')
    $('.content').append(form)

  completeTask: (task)->
    $.ajax('/api/lists/'+this.list+'/tasks/'+$(task).data('id'),
      type: 'DELETE'
    ).done(=>
      @.renderTasks(@.list)
    )

$ ->
  window.Tasks = new Tasks

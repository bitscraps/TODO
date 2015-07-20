class Tasks
  renderTasks: (list) ->
    console.log(list)
    tasks = $('<div class=tasks>')
    title = $('<h1>Your Tasks</h1>')

    tasks.append(title)
    $('body').html(tasks)

    $.get('/api/lists/'+list+'/tasks')
    .done( (data)=>
      $.each(data, (index, task)=>
        this.renderTaskBlock(task)
      )
    )

  renderTaskBlock: (task) ->
    task_item = $('<div class="task">'+task.name+'</div>')

    $('body').append(task_item)


$ ->
  window.Tasks = new Tasks

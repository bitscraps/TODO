class Api::TasksController < ApiController
  before_action :authenticate_user!

  def index
    list = @current_user.lists.find(params[:list_id])

    if list
      render json: list.tasks, status: 200
    else
      render json: {}, status: 422
    end
  end

  def create
    list = @current_user.lists.find(params[:list_id])
    task = list.tasks.new(task_params)

    if task.save
      render json: task, status: 201
    else
      render json: { errors: task.errors.full_messages }, status: 422
    end
  end

  def destroy 
    list = @current_user.lists.find(params[:list_id])
    task = list.tasks.find(params[:id])

    if task.update(complete: true)
      render json: task, status: 200
    else
      render json: { errors: task.errors.full_messages }, status: 422
    end
  end

  def update
    list = @current_user.lists.find(params[:list_id])
    task = list.tasks.find(params[:id])

    if task.update(task_params)
      render json: task, status: 200
    else
      render json: { errors: task.errors.full_messages }, status: 422
    end
  end

  private

  def task_params
    params[:task].permit(:name)
  end
end

class Api::ListsController < ApiController
  before_action :authenticate_user!

  def create
    list = @current_user.lists.new(list_params)
    list.archived = false

    if list.save
      render json: list, status: 201
    else
      render json: { errors: list.errors.full_messages }, status: 422
    end
  end

  def destroy
    list = @current_user.lists.find(params[:id])

    if list.update(archived: true)
      render json: list, status: 204
    else
      render json: { errors: list.errors.full_messages }, status: 422
    end
  end

  def index
    if params[:archived] == true
      render json: @current_user.lists, status: 200
    else
      render json: @current_user.lists.unarchived, status: 200
    end
  end

  def update
    list = @current_user.lists.find(params[:id])

    if list.update(list_params)
      render json: list, status: 200
    else
      render json: { errors: list.errors.full_messages }, status: 422
    end
  end

  private

  def list_params
    params[:list].permit(:name)
  end
end

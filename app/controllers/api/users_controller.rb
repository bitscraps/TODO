class Api::UsersController < ApiController
  def create
    user = User.new(user_params)

    if user.save
      session[:logged_in] = user.id
      render json: user, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params[:user].permit(:username, :password, :password_confirmation)
  end
end

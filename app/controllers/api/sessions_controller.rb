class Api::SessionsController < ApiController
  def create
    user = User.where(username: params[:username]).first

    if user && is_password?(user, params[:password])
      session[:logged_in] = user.id
      render json: {}, status: 201
    else
      render json: { error: 'unable to login' }, status: 422
    end
  end

  def destroy
    session[:logged_in] = nil
    render json: {}, status: 204
  end

  private 

  def is_password?(user, password)
    BCrypt::Password.new(user.hashed_password).is_password? password
  end
end

class Api::SessionsController < ApiController
  def create
    user = User.where(username: params[:username]).first

    puts User.all.inspect

    if user && user.is_password?(params[:password])
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
end

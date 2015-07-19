class ApiController < ApplicationController
  def authenticate_user!
    if session[:logged_in].nil?
      render json: { error: 'Not logged in' }, status: 401 and return
    end

    @current_user = User.find(session[:logged_in])
  end
end

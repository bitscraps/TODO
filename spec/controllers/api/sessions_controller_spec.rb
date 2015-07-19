require 'rails_helper'

describe Api::SessionsController do
  describe '#create' do
    it 'should create a new session for a valid user' do
      user = create(:user)
      post :create, { username: user.username, password: 'password' }

      expect(response.status).to eq 201
      expect(session[:logged_in]).to eq user.id
    end
  end

  describe '#destroy' do
    it 'should destroy a session for a valid user' do
      user = create(:user)

      session[:logged_in] = user.id

      delete :destroy

      expect(response.status).to eq 204
      expect(session[:logged_in]).to eq nil
    end
  end
end

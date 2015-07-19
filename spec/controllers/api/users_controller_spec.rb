require 'rails_helper'

describe Api::UsersController do
  describe '#create' do
    it 'should create a new user' do
      post :create, user: { username: 'graham@test.com', password: 'password', password_confirmation: 'password' }

      expect(response.status).to eq 201

      expect(User.count).to eq 1
      expect(User.first.username).to eq 'graham@test.com'
    end

    it 'should provide errors if a username is not provided' do
      post :create, user: { }

      expect(response.status).to eq 422

      expect(User.count).to eq 0
    end
  end
end

require 'rails_helper'

describe Api::ListsController do
  describe 'if a user is not logged in' do
    it 'should return an error' do
      post :create, list: { name: 'A New List' }

      expect(response.status).to eq 401
    end
  end

  describe 'if a user is logged in' do
    before(:each) do
      @user = create(:user)
      session[:logged_in] = @user.id
    end

    describe '#create' do
      it 'should create a new list for the current user' do
        post :create, list: { name: 'A New List' }

        expect(response.status).to eq 201

        expect(@user.lists.count).to eq 1
        expect(@user.lists.first.name).to eq 'A New List'
      end
    end

    describe '#index' do
      before(:each) do
        2.times { create(:list, user: @user) }
        create(:archived_list, user: @user)
      end

      it 'should return a list of unarchived lists for the current user' do
        get :index

        lists = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(lists.count).to eq 2
      end

      it 'should return a list of all lists for the current user' do
        get :index, archived: true

        lists = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(lists.count).to eq 3
      end
    end

    describe '#update' do
      it 'should update the name of the list' do
        list = create(:list, user: @user)

        put :update, id: list.id, list: { name: 'Updated Name' }

        expect(response.status).to eq 200

        updated_list = List.find(list.id)
        
        expect(updated_list.name).to eq 'Updated Name'
      end
    end

    describe '#destroy' do
      it 'should archive the list' do
        list = create(:list, user: @user)
      
        delete :destroy, id: list.id

        archived_list = List.find(list.id)

        expect(response.status).to eq 204
        expect(archived_list.archived).to eq true
      end
    end
  end
end

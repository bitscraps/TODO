require 'rails_helper'

describe Api::TasksController do
  describe 'if a user is not logged in' do
    it 'should return an error' do
      user = create(:user)
      list = create(:list, user: user)

      get :index, list_id: list.id

      expect(response.status).to eq 401
    end
  end

  describe 'if a user is logged in' do
    before(:each) do
      user = create(:user)
      session[:logged_in] = user.id
      
      @list = create(:list, user: user)
    end

    describe '#index' do
      it 'returns the tasks for the current list' do
        2.times { create(:task, list: @list) }

        get :index, list_id: @list.id

        tasks = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(tasks.count).to eq 2
      end
    end

    describe '#create' do
      it 'creates a task for the current list' do
        post :create, list_id: @list.id, task: { name: 'A task to complete' }

        expect(response.status).to eq 201
        expect(Task.count).to eq 1
        expect(Task.first.name).to eq 'A task to complete'
      end
    end

    describe '#update' do
      it 'updates the name of a task' do
        task = create(:task, list: @list)

        put :update, list_id: @list.id, id: task.id, task: { name: 'A new name for the task' }

        expect(response.status).to eq 200

        updated_task = Task.find(task.id)

        expect(updated_task.name).to eq 'A new name for the task'
      end
    end

    describe '#destroy' do
      it 'updates the status of a task to complete' do
        task = create(:task, list: @list)

        delete :destroy, list_id: @list.id, id: task.id

        expect(response.status).to eq 200

        complete_task = Task.find(task.id)

        expect(complete_task.complete).to eq true
      end
    end
  end
end

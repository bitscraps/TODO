require 'rails_helper'

feature 'a user can manage their tasks' do
  before(:each) do
    @user = create(:user, username: 'graham', password: 'password')
    @list = create(:list, user: @user, name: 'A sample list')
  end

  scenario 'can view their tasks for a list', js: true do
    task = create(:task, list: @list)

    login_and_navigate_to_task

    within '.tasks' do
      expect(page).to have_content task.name
    end
  end

  scenario 'can create a new task', js: true do
    login_and_navigate_to_task

    within '.right-action' do
      click_link 'Create a new task'
    end

    within '.form' do
      fill_in :task_name, with: 'a new task'
      click_button 'Create Task'
    end

    within '.task' do
      expect(page).to have_content 'a new task'
    end
  end

  scenario 'can complete a task', js: true do
    task = create(:task, list: @list)

    login_and_navigate_to_task

    click_link 'Complete'

    wait_for_ajax

    expect(page).to have_css("div#task#{task.id}.complete")
  end

  it 'can change the name of a task', js: true do
    task = create(:task, list: @list)

    login_and_navigate_to_task

    click_link 'Change Name'

    wait_for_ajax

    within '.form' do
      fill_in :task_name, with: 'a new name'
      click_button 'Change Name'
    end

    wait_for_ajax

    expect(page).to have_content 'a new name'
  end

  it 'can go back to the lists view', js: true do
    login_and_navigate_to_task

    click_link 'back to lists'

    expect(page).to have_content @list.name
  end

  def login_and_navigate_to_task
    visit '/'

    within '.login' do
      fill_in :username, with: 'graham'
      fill_in :password, with: 'password'
      click_button 'Log In'
    end

    wait_for_ajax

    find('span', :text => @list.name).click

    wait_for_ajax
  end
end

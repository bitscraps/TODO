require 'rails_helper'

feature 'a user can manage their tasks' do
  before(:each) do
    @user = create(:user, username: 'graham', password: 'password')
    @list = create(:list, user: @user, name: 'A sample list')
  end

  scenario 'can view their tasks for a list', js: true do
    task = create(:task, list: @list)

    login_and_navigate_to_task

    expect(page).to have_content task.name
  end

  pending 'can create a new tasks'

  pending 'can complete a task'

  pending 'can change the name of a task'

  def login_and_navigate_to_task
    visit '/'

    within '.login' do
      fill_in :username, with: 'graham'
      fill_in :password, with: 'password'
      click_button 'Log In'
    end

    wait_for_ajax

    find('.list', :text => @list.name).click
  end
end

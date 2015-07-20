require 'rails_helper'

feature 'a user can manage their lists' do
  before(:each) do
    @user = create(:user, username: 'graham', password: 'password')
  end

  scenario 'can view their lists', js: true do
    create(:list, user: @user, name: 'A sample list')

    login

    expect(page).to have_content 'A sample list'
  end

  scenario 'can create a new list', js:true do
    login

    click_link 'Create a new list'

    within '.form' do
      fill_in :list_name, with: 'a new list'
      click_button 'Create List'
    end

    wait_for_ajax

    expect(page).to have_content 'a new list'

  end

  scenario 'can archive a list', js: true do
    list = create(:list, user: @user)

    login

    click_link 'Archive List'

    wait_for_ajax

    expect(page).to_not have_content list.name
  end

  scenario 'can change the name of a list', js: true do
    list = create(:list, user: @user)

    login

    click_link 'Change Name'

    wait_for_ajax

    within '.form' do
      fill_in :list_name, with: 'a new name'
      click_button 'Change Name'
    end

    wait_for_ajax

    expect(page).to have_content 'a new name'
  end

  def login
    visit '/'

    within '.login' do
      fill_in :username, with: 'graham'
      fill_in :password, with: 'password'
      click_button 'Log In'
    end

    wait_for_ajax
  end
end

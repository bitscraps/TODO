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

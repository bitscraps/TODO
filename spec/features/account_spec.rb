require 'rails_helper'

feature 'An unauthenticated user' do
  scenario 'an unauthenticated user can create an account', js: true do
    visit '/'

    within '.login' do
      click_link 'Create an account'
    end

    within '.create_account' do
      fill_in :user_username, with: 'graham'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      click_button 'Create my account'
    end

    wait_for_ajax

    expect(page).to have_content 'Your Lists'
  end
end

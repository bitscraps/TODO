require 'rails_helper'

feature 'an unauthenticated user' do
  before(:each) do
    user = User.new(username: 'graham', password: 'password')
    user.save
  end

  scenario 'cannot login if their details are incorrect', js: true do
    visit '/'
    within '.login' do
      fill_in :username, with: 'graham.hadgraft@gmail.com'
      fill_in :password, with: 'letmein'
      click_button 'Log In'
    end

    expect(page).to_not have_content 'Your Lists'
  end

  scenario 'cannot login if their details are incorrect', js: true do
    visit '/'
    within '.login' do
      fill_in :username, with: 'graham'
      fill_in :password, with: 'password'
      click_button 'Log In'
    end

    wait_for_ajax

    expect(page).to have_content 'Your Lists'
  end
end

require 'rails_helper'

describe User do
  it 'has many lists' do
    expect(User.new).to have_many :lists
  end

  it 'should validate presence of a username' do
    expect(User.new).to validate_presence_of :username
  end

  it 'should validate the uniqueness of a username' do
    expect(User.new).to validate_uniqueness_of :username
  end

  it 'should validate presence of password' do
    expect(User.new).to validate_presence_of :password
  end

  it 'should validate confirmation of password' do
    expect(User.new).to validate_confirmation_of :password
  end

  it 'should hash the password when saving a user' do
    user = User.new(username: 'graham@test.com', password: 'password', password_confirmation: 'password')
    user.save

    expect(user.hashed_password).to_not eq nil
  end
end

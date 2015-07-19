FactoryGirl.define do
  factory :user do
    username { Faker::Internet.email }
    password 'password'
  end
end


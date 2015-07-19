FactoryGirl.define do
  factory :list do
    name { Faker::Commerce.department }
    archived false

    user

    factory :archived_list do
      archived true
    end
  end

end

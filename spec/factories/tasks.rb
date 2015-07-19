FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.sentence }
    complete false

    factory :complete_task do
      complete true
    end
  end

end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :label do
    name { Faker::Hacker.noun }
  end
end

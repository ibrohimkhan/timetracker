# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name { Faker::Name.title }
    description { Faker::Hacker.say_something_smart }
    parent_id { Faker::Number.digit }
    state false
  end
end

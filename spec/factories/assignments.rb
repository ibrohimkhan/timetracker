# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    association :user
    association :task
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    association :task
    file_path { Faker::Internet.url }
  end
end

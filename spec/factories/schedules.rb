# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    association :task
    start_date "2014-07-20"
    end_date "2014-07-27"
  end
end
